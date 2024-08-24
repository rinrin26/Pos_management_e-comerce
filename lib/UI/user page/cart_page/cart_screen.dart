import 'dart:convert';
import 'dart:math';

import 'package:final_project_application_pos/bloc/cart_bloc/cart_bloc.dart';

import 'package:final_project_application_pos/UI/user%20page/cart_page/listview_cart.dart';
import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:final_project_application_pos/bloc/order_bloc/order_bloc.dart';
import 'package:final_project_application_pos/helper/notification_helper.dart';
import 'package:final_project_application_pos/model/cart_model.dart';
import 'package:final_project_application_pos/model/order_model.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

// Use the prefix to refer to the specific CartLoaded class
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Cart'),
            const SizedBox(width: 156),
            const Text('Ubah', style: TextStyle(color: Colors.black54)),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble, color: Colors.orange),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListViewWidget(
                    data: state.products,
                  ),
                ),
                bottomContent(state.cartItem!)
              ],
            );
          } else if (state is CartInitial) {
            return const Center(child: Text('Cart is empty'));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget bottomContent(List<CartModel> cartItems) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        double totalPrice = 0.0;

        if (state is CartLoaded) {
          totalPrice = state.totalPrice;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(2, 2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp. ${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ButtonWidget(
                text: 'Checkout',
                onPressed: () async {
                  final orderId = Uuid().v4();
                  final dataOrder = OrderModel(
                    orderId: orderId,
                    productOrder: cartItems,
                  );
                  context
                      .read<OrderBloc>()
                      .add(SaveOrderToFirestore(dataOrder));
                  await NotificationHelper.flutterLocalNotificationsPlugin.show(
                      Random().nextInt(99),
                      'Successfull !!',
                      'data has been successfully added to the order',
                      payload: jsonEncode({'data': 'test'}),
                      NotificationHelper.notificationDetails);
                  context.push(RouteNames.payment);
                  // context.push(Uri(
                  //         path: RouteNames.payment,
                  //         queryParameters: dataOrder.toMap())
                  //     .toString());
                },
                buttonColor: Colors.blue.shade800,
                textColor: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
