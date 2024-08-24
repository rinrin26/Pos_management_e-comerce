part of 'inventory_product_bloc.dart';

class InventoryProductState extends Equatable {
   final List<InventoryProductModel> product;
  const InventoryProductState({this.product = const []});

  @override
  List<Object> get props => [product];
}

class InventoryLoaded extends InventoryProductState {
  final List<InventoryProductModel> products;
  final List<String>? lowStockProducts;

  const InventoryLoaded({required this.products, this.lowStockProducts});

  @override
   List<Object> get props => [products];
}

class InventoryError extends InventoryProductState {
  final String message;

  const InventoryError(this.message);

  @override
 List<Object> get props => [message];
}
