import 'package:final_project_application_pos/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// class ApiService menangani permintaan HTTP untuk mengambil data pengguna.

class ApiService {
  // baseUrl: URL default/dasar API.
  final String baseUrl = 'https://fakestoreapi.com';


  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load Product');
    }
  }

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
