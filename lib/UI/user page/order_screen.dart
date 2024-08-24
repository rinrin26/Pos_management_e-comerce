import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orderItems = [
    {
      'name': 'Product 1',
      'price': 10000,
      'quantity': 2,
    },
    {
      'name': 'Product 2',
      'price': 20000,
      'quantity': 1,
    },
    {
      'name': 'Product 3',
      'price': 15000,
      'quantity': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = orderItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('${item['quantity']} x Rp${item['price']}'),
                    trailing: Text('Rp${item['price'] * item['quantity']}'),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp$totalPrice',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ButtonWidget(
              text: 'Proceed to Payment',
              onPressed: () {
                context.push(RouteNames.payment);
              },
              icon: Icons.save,
              buttonColor: Colors.blue.shade800,
              textColor: Colors.white,
            ),
            
          ],
        ),
      ),
    );
  }
}
