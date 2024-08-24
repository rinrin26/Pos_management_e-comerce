part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
  
  @override
  List<Object> get props => [];
}

class AddProductToCart extends CartEvent {
  final ProductModel product;
   final CartModel cartItem;
  AddProductToCart(this.product, this.cartItem);
}

class UpdateProductQuantity extends CartEvent {
  final int productId;
  final int quantity;

  UpdateProductQuantity(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

class DeleteProductFromCart extends CartEvent {
  final int productId;

  DeleteProductFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdatedQuantity extends CartEvent{
  final int quantity;
 final int productId;

  UpdatedQuantity({required this.quantity, required this.productId});
  @override
  List<Object> get props => [quantity, productId];

}



class UpdatedTotalItemPrice extends CartEvent {
  final double  total;
  final int productId;

  UpdatedTotalItemPrice({required this.total, required this.productId});
  @override
  List<Object> get props => [total, productId];
}
