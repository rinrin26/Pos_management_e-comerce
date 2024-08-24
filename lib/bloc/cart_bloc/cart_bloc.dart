import 'package:bloc/bloc.dart';
import 'package:final_project_application_pos/model/cart_model.dart';
import 'package:final_project_application_pos/model/product_model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {

    on<AddProductToCart>((event, emit) {
      final currentState = state;
      List<ProductModel> updatedProducts = [];
      List<CartModel> updatedCartItem = [];

      if (currentState is CartLoaded) {
        updatedProducts = List.from(currentState.products);
        updatedCartItem = List.from(currentState.cartItem!);
      }

      updatedProducts.add(event.product);

      final dataCartItem = CartModel(
        productId: event.product.id,
        quantity: 1,
        price: event.product.price,
        total: event.product.price * 1,
      );
      updatedCartItem.add(dataCartItem);
      final newTotalPrice = updatedCartItem.fold<double>(
        0.0,
        (total, item) => total + item.total!,
      );

      emit(CartLoaded(updatedProducts, updatedCartItem, newTotalPrice));
    });

    on<UpdateProductQuantity>((event, emit) {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final updatedProducts = List<ProductModel>.from(currentState.products);
        final updatedCartItems = List<CartModel>.from(currentState.cartItem!);

        //mencari id product yg sama dengan di product cart
        final findProduct = updatedProducts
            .indexWhere((product) => product.id == event.productId);
        final itemCart = updatedCartItems
            .indexWhere((cartItem) => cartItem.productId == event.productId);
        //check kondisi keduanya index yg dicari tidak boleh kurang dari 0
        if (findProduct != -1 && itemCart != -1) {
          //update qty
          final updatedCartItem = updatedCartItems[itemCart].copyWith(
            quantity: event.quantity,
          );
          updatedCartItems[itemCart] = updatedCartItem;

          //mengupdate total per item cart
          final updatedCartItemsWithPrice = updatedCartItems.map((item) {
            final product =
                updatedProducts.firstWhere((p) => p.id == item.productId);
            final newTotal = product.price * item.quantity;
            return item.copyWith(total: newTotal);
          }).toList();

          // total didapat dari menjumlahkan semua item yang ada dicart
          final newTotalPrice = updatedCartItemsWithPrice.fold<double>(
              0.0, (total, item) => total + item.total!);

          emit(CartLoaded(updatedProducts, updatedCartItems, newTotalPrice));
        }
      }
    });
  }
}
