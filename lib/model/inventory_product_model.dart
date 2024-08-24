import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryProductModel {
  String id;
  String productName;
  String sku;
  double price;
  String description;
  String? productImg;
  String category;
  String gender;
  int? stock;


  InventoryProductModel({
    required this.id,
    required this.productName,
    required this.sku,
    required this.price,
    required this.description,
    this.productImg,
    required this.category,
    required this.gender,
    this.stock,
 
  });

  factory InventoryProductModel.fromJson(Map<String, dynamic> json) {
    return InventoryProductModel(
      id: json['id'],
      productName: json['productName'],
      sku: json['sku'],
      price: json['price'],
      description: json['description'],
      productImg: json['productImg'],
      category: json['category'],
      gender: json['gender'],
      stock: json['stock'],

    );
  }
   Map<String, String> toMap() {
    return {
      'id': id,
      'productName': productName,
      'sku': sku,
      'price': price.toString(),
      'description': description,
      'productImg': productImg!,
      'category':category,
      'gender': gender,
      'stock': stock.toString()

    };
  }

  static InventoryProductModel fromMap(Map<String, String> map) {
    return InventoryProductModel(
      id: map['id']!,
      productName: map['productName']!,
       sku:  map['sku']!,
      price: double.tryParse(map['price'] ?? '0') ?? 0,
      description: map['description']!,
      category: map['category']!,
      productImg: map['productImg']!,
      gender: map['gender']!,
      stock:  int.tryParse(map['stock'] ?? '0') ?? 0,
      
    );
  }

  factory InventoryProductModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InventoryProductModel(
      id: doc.id,
      productName: data['productName'],
      sku: data['sku'],
      price: data['price'].toDouble(),
      description: data['description'],
      productImg: data['productImg'],
      category: data['category'],
      gender: data['gender'],
      stock: data['stock'],
    );
  }
}
