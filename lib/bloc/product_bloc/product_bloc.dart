
import 'package:equatable/equatable.dart';
import 'package:final_project_application_pos/model/product_model.dart';
import 'package:final_project_application_pos/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_event.dart';
part 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductLoading()) {
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await apiService.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });

    on<SearchProductsEvent>((event, emit) async {
      final products = await apiService.fetchProducts();

      final filterProducts = products
          .where((product) =>
              product.title.contains(event.query))
          .toList();

      emit(ProductLoaded(products: filterProducts));
    });
  }
}
