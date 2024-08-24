import 'package:final_project_application_pos/model/cart_model.dart';
import 'package:final_project_application_pos/model/inventory_product_model.dart';
import 'package:final_project_application_pos/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
//auth
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.uid);
        return user;
      }
      print('======== returnnnn $user');
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final result =
        prefs.getString('user_id') != null && prefs.containsKey('user_id');

    return result;
  }

  Future<void> addUser(
      String uid, String email, String nama, String noHP) async {
    try {
      await db.collection('users').add({
        'uid': uid,
        'email': email,
        'nama': nama,
        'noHP': noHP,
      });
    } catch (e) {
      throw Exception('Gagal menambahkan data: $e');
    }
  }

  Future<void> updateUser(String userId, String nama, int noHP) async {
    try {
      await db.collection('users').doc(userId).update({
        'nama': nama,
        'noHP': noHP,
      });
    } catch (e) {
      throw Exception('Gagal mengupdate data: $e');
    }
  }

//inventory
  Future<void> addProductInventory(InventoryProductModel product) async {
    try {
      await db.collection('products').add({
        'id': product.id,
        'productName': product.productName,
        'sku': product.sku,
        'price': product.price,
        'description': product.description,
        'productImg': product.productImg,
        'category': product.category,
        'gender': product.gender,
      });
    } catch (e) {
      throw Exception('Gagal menambahkan data: $e');
    }
  }

  Future<List<InventoryProductModel>> getProductsInventory() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('products').get();
      print('=====data firestore service $querySnapshot');
      return querySnapshot.docs.map((doc) {
        return InventoryProductModel.fromSnapshot(doc);
      }).toList();
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  Future<void> removeProductFromFirestore(String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();
      print('Product $productId deleted from Firestore');
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }


  Future<void> savePaymentMethodToFirestore(String methodName) async {
    final uuid = Uuid();
    final randomId = uuid.v4();
    try {
      await db.collection('payment').add({
        'id': randomId,
        'methodName': methodName,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed add data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPaymentMethodFromDbPayment(
      String methodName) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('payment')
          .where('methodName', arrayContains: methodName)
          .get();

      return querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      throw Exception('failed get data: $e');
    }
  }

  //save order / checkout
  Future<void> saveCheckoutOrder(OrderModel order) async {
    final uuid = Uuid();
    final randomId = uuid.v4();
    try {
      for (var productOrder in order.productOrder) {
        await db.collection('orders').add({
          'orderId': randomId,
          'productId': productOrder.productId,
          'quantity': productOrder.quantity,
          'price': productOrder.price,
          'total': productOrder.total,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Failed to add data: $e');
    }
  }

  
  Future<List<OrderModel>> getOrders() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('orders').get();
      final result = querySnapshot.docs.map((doc) {
        return OrderModel.fromSnapshot(doc);
      }).toList();
      print('=====get data order firestore service $result');
      return result;
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  Future<List<OrderModel>> getOrderByOrderId(String orderId) async {
    try {
      QuerySnapshot querySnapshot = await db.collection('orders').get();
      final result = querySnapshot.docs.map((doc) {
        return OrderModel.fromSnapshot(doc);
      }).toList();
      print('=====get data order firestore service $result');
      return result;
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }


}
