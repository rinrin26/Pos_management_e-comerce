part of 'cart_bloc.dart';


abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<ProductModel> products;
  final List<CartModel>? cartItem;
  final double totalPrice;
  
  CartLoaded(this.products, this.cartItem, this.totalPrice); //:totalPrice = _calculateTotalPrice(cartItem!)

  static double _calculateTotalPrice(List<CartModel> cartItems) {
    return cartItems.fold(0.0, (total, item) {
      return total + item.total!;
    });
  }
}
