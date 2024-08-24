import 'package:final_project_application_pos/bloc/cart_bloc/cart_bloc.dart';
import 'package:final_project_application_pos/bloc/product_bloc/product_bloc.dart';
import 'package:final_project_application_pos/model/cart_model.dart';
import 'package:final_project_application_pos/model/product_model.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is ProductLoaded) {
              final products = state.products;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(child: listProducts(products: products)),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  TextField _searchBar(BuildContext context) => TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: 'Search',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        onChanged: (query) {
          context.read<ProductBloc>().add(SearchProductsEvent(query));
        },
      );

  Widget listProducts({required List<ProductModel> products}) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              context.push(Uri(
                      path: RouteNames.detailProduct,
                      queryParameters: product.toMap())
                  .toString());
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      product.image,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      maxLines: 2,
                      product.title,
                      style: const TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade700,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              final cartItem = CartModel(productId: product.id, quantity: 1, total: product.price);
                               context
                                  .read<CartBloc>()
                                  .add(AddProductToCart(product, cartItem));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${product.title} added to cart'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}