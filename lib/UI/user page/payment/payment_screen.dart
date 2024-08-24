import 'dart:convert';
import 'dart:math';

import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_widget.dart';
import 'package:final_project_application_pos/helper/notification_helper.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:final_project_application_pos/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatefulWidget {
 
  const PaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  FirestoreServices firestoreServices = FirestoreServices();
  String? selectedPayment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              text: 'E-wallets',
            ),
            const SizedBox(height: 10),
            _buildPaymentList(),
            const SizedBox(height: 20),
            const TextWidget(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              text: 'Banks',
            ),
            const SizedBox(height: 10),
            _buildBankTransferList(),
            const Spacer(),
            _buildProceedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentList() {
    final List<Map<String, dynamic>> ewallets = [
      {'name': 'OVO', 'img': 'assets/images/ovo2.png'},
      {'name': 'GoPay', 'img': 'assets/images/gopay.png'},
      {'name': 'Dana', 'img': 'assets/images/dana.png'},
      {'name': 'ShopeePay', 'img': 'assets/images/shopeepay.jpg'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ewallets.map((wallet) {
        return RadioListTile<String>(
          value: wallet['name'],
          groupValue: selectedPayment,
          title: Text(wallet['name']),
          secondary: Image.asset(
            wallet['img'],
            width: 40,
            height: 40,
          ),
          onChanged: (value) {
            setState(() {
              selectedPayment = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildBankTransferList() {
    final List<Map<String, dynamic>> banks = [
      {'name': 'BRI', 'img': 'assets/images/bri.jpg'},
      {'name': 'BCA', 'img': 'assets/images/bca.jpg'},
      {'name': 'Mandiri', 'img': 'assets/images/mandiri.png'},
      {'name': 'BNI', 'img': 'assets/images/bni.png'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: banks.map((bank) {
        return RadioListTile<String>(
          value: bank['name'],
          groupValue: selectedPayment,
          title: Text(bank['name']),
          secondary: Image.asset(
            bank['img'],
            width: 40,
            height: 40,
          ),
          onChanged: (value) {
            setState(() {
              selectedPayment = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return SizedBox(
        child: ButtonWidget(
      text: 'Proceed to Status',
      onPressed: () async {
        if (selectedPayment != null) {
          firestoreServices.savePaymentMethodToFirestore(selectedPayment!);
        }
        await NotificationHelper.flutterLocalNotificationsPlugin.show(
            Random().nextInt(99),
            'Successfull !!',
            'payment methos has been successfully save',
            payload: jsonEncode({'data': 'test'}),
            NotificationHelper.notificationDetails);
        context.push(Uri(
          path: RouteNames.statusPage,
          query: selectedPayment,
        ).toString());
      },
      buttonColor: Colors.blue.shade800,
      textColor: Colors.white,
    ));
  }
}
