import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_application_pos/model/cart_model.dart';

class OrderModel {
  String orderId;
  final List<CartModel> productOrder;
  OrderModel({required this.orderId, required this.productOrder});

 Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'productOrder': productOrder.map((cart) => cart.toMap()).toList(),
    };
  }

  

  factory OrderModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrderModel(orderId: doc.id, productOrder: 
    [
      CartModel(
          productId: data['productId'],
          quantity: data['quantity'],
          total: data['total'],
          price: data['price'])
    ]);
  }
  
  
}


