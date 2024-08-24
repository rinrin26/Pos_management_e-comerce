import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_application_pos/model/inventory_product_model.dart';
import 'package:final_project_application_pos/services/firestore_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'inventory_product_event.dart';
part 'inventory_product_state.dart';

class InventoryProductBloc
    extends Bloc<InventoryProductEvent, InventoryProductState> {
  FirestoreServices firestoreServices = FirestoreServices();
  final db = FirebaseFirestore.instance;

  InventoryProductBloc() : super(const InventoryProductState()) {
    on<AddInventoryProduct>((event, emit) async {
      await firestoreServices.addProductInventory(event.product);
    });

    on<GetProductsInventory>((event, emit) async {
      try {
        final products = await firestoreServices.getProductsInventory();
        print('======== data invetory bloc get product $products');

        final lowStockProductIds = products
            .where((product) => product.stock != null && product.stock! < 100)
            .map((product) => product.productName)
            .toList();

        emit(InventoryLoaded(
            products: products, lowStockProducts: lowStockProductIds));
      } catch (e) {
        emit(InventoryError('Failed to fetch products: $e'));
      }
    });

    on<UpdateProductInventory>((event, emit) async {
      emit(InventoryProductState(product: event.product));
    });

    on<RemoveProductEvent>((event, emit) async {
      if (state is InventoryLoaded) {
        final currentState = state as InventoryLoaded;
        final products = currentState.products;

        // cari index product based on product id
        final index =
            products.indexWhere((product) => product.id == event.productId);

        if (index != -1) {
          await firestoreServices.removeProductFromFirestore(event.productId);

          final updatedProducts = List.of(products)..removeAt(index);

          emit(InventoryLoaded(products: updatedProducts));
        } else {
          emit(const InventoryError("Product not found in the list."));
        }
      }
    });

    on<SearchInventoryProductsEvent>((event, emit) async {
      final products = await firestoreServices.getProductsInventory();

      final filterProducts = products
          .where((product) => product.productName.contains(event.query))
          .toList();

      emit(InventoryLoaded(products: filterProducts));
    });
  }
}
