part of 'order_bloc.dart';

abstract class OrderEvent {
  const OrderEvent();

  @override
  List<Object> get props => [];
}
class GetOrders extends OrderEvent {}

class AddProductToCart extends OrderEvent {
  final ProductModel product;
  AddProductToCart(this.product);
}

class UpdateProductQuantity extends OrderEvent {
  final int productId;
  final int quantity;

  UpdateProductQuantity(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

class DeleteProductFromCart extends OrderEvent {
  final int productId;

  DeleteProductFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}


class SaveOrderToFirestore extends OrderEvent {
  final OrderModel order;
  SaveOrderToFirestore(this.order);
  @override
  List<Object> get props => [order];
}


