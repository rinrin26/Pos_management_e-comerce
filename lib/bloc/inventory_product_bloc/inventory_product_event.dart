part of 'inventory_product_bloc.dart';


sealed class InventoryProductEvent extends Equatable {
  const InventoryProductEvent();
  @override
  List<Object> get props => [];
}

class GetProductsInventory extends InventoryProductEvent{}

class AddInventoryProduct extends InventoryProductEvent{
   final InventoryProductModel product;

  const AddInventoryProduct({required this.product});
  @override
  List<Object> get props => [product];
}

class UpdateProductInventory extends InventoryProductEvent {
  final List<InventoryProductModel> product;

  const UpdateProductInventory({required this.product});
  @override
  List<Object> get props => [product];
}
class RemoveProductEvent extends InventoryProductEvent {
  final String productId ;

  const RemoveProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class SearchInventoryProductsEvent extends InventoryProductEvent {
  final String query;
  SearchInventoryProductsEvent(this.query);
}

