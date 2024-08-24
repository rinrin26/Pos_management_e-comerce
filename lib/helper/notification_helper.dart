import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static ValueNotifier<String> payload = ValueNotifier("");

  void setPayload(String newPayload) {
    payload.value = newPayload;
  }

  static AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails("Notif", "Sanber FInal Project",
          channelDescription: 'Tugas Final Project Local Notif ',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true);

  static DarwinNotificationDetails iOSNotificationDetails =
      const DarwinNotificationDetails(
          threadIdentifier: 'local_notif',
          presentAlert: true,
          presentBadge: true,
          presentSound: true);

  static NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: iOSNotificationDetails);

  Future<void> initLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint("Show Notification  ${details.payload}");
        setPayload(details.payload ?? '');
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }
}
