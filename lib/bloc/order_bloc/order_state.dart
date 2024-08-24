part of 'order_bloc.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded(this.orders);
}
class OrderError extends OrderState {
  final String message;

   OrderError(this.message);

  @override
  List<Object> get props => [message];
}
