import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {

  int productId;
  int quantity;
  double? total;
  double? price;
  CartModel({
    required this.productId,
    required this.quantity,
    this.total,
    this.price,
  });

  CartModel copyWith({
    int? productId,
    int? quantity,
    double? total,
    double? price,
      String? orderId
  }) {
    return CartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      price: price ?? this.price,
    );
  }

  factory CartModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel(
      productId: data['productId'],
      quantity: data['quantity'],
      total: data['total'],
      price: data['price'],
     
    );
  }

    Map<String, String> toMap() {
    return {
      'productId': productId.toString(),
      'quantity': quantity.toString(),
      'price': price.toString(),
      'total': total.toString(),
    };
  }

  


  
}
