import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Center(
            child: Column(
          children: [
            Text(
              'ini untuk notifikasi',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
    );
  }
}
