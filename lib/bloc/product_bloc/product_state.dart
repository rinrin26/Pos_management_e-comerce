

part of 'product_bloc.dart';



abstract class ProductState extends Equatable {}


class ProductLoading extends ProductState {
   @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

  @override
  List<Object> get props => [message];
}