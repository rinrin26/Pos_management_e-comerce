import 'package:final_project_application_pos/bloc/order_bloc/order_bloc.dart';
import 'package:final_project_application_pos/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportSellerScreen extends StatefulWidget {
  const ReportSellerScreen({super.key});

  @override
  State<ReportSellerScreen> createState() => _ReportSellerScreenState();
}

class _ReportSellerScreenState extends State<ReportSellerScreen> {



  final List<TransactionModel> transactions = [
    TransactionModel(
      orderId: 'ORD12345',
      productId: 'PROD67890',
      quantity: 2,
      pricePerProduct: 150.0,
      totalPrice: 300.0,
      paymentMethod: 'GoPay',
      transactionDate: DateTime.now().subtract(Duration(days: 1)),
    ),
    TransactionModel(
      orderId: 'ORD67891',
      productId: 'PROD12345',
      quantity: 1,
      pricePerProduct: 200.0,
      totalPrice: 200.0,
      paymentMethod: 'OVO',
      transactionDate: DateTime.now().subtract(Duration(days: 2)),
    ),
    // Tambahkan transaksi lain sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Page'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text('Order ID: ${transaction.orderId}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product ID: ${transaction.productId}'),
                  Text('Quantity: ${transaction.quantity}'),
                  Text(
                      'Price per Product: \$${transaction.pricePerProduct.toStringAsFixed(2)}'),
                  Text(
                      'Total Price: \$${transaction.totalPrice.toStringAsFixed(2)}'),
                  Text('Payment Method: ${transaction.paymentMethod}'),
                  // Text(
                  //     'Transaction Date: ${DateFormat('yyyy-MM-dd').format(transaction.transactionDate)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
