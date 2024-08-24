import 'package:final_project_application_pos/UI/nav_menu/app_drawer.dart';
import 'package:final_project_application_pos/UI/widget/alert_dialog_widget.dart';
import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_field_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_widget.dart';
import 'package:final_project_application_pos/bloc/inventory_product_bloc/inventory_product_bloc.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InventoryProductScreen extends StatefulWidget {
  const InventoryProductScreen({super.key});

  @override
  State<InventoryProductScreen> createState() => _InventoryProductScreenState();
}

class _InventoryProductScreenState extends State<InventoryProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InventoryProductBloc>().add(GetProductsInventory());
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const TextWidget(
          text: 'Inventory',
          style: TextStyle(fontSize: 25),
        ),
      ),
      endDrawer: const AppDrawer(),
      body:BlocListener<InventoryProductBloc, InventoryProductState>(
        listener: (context, state) {
          if (state is InventoryLoaded) {
            if (state.lowStockProducts!.isNotEmpty) {
              showCustomAlertDialog(
                context,
                'Stock is low!',
                'Products with low stock : ${state.lowStockProducts?.join(', ')}',
                'Update',
                () {
                  context.push(RouteNames.inventory);
                },
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Product List',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ButtonWidget(
                    text: 'Add',
                    textColor: Colors.white,
                    onPressed: () {
                      context.push( RouteNames.addProduct).toString();
                    },
                    btnHeight: 44,
                    btnWidth: 145,
                    icon: Icons.add,
                    buttonColor: Colors.blue.shade900,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: searchController,
                hintText: 'Search',
                prefixIcon: Icons.search,
                usePrimaryDecoration: true,
                onChanged: (query) {
                  context.read<InventoryProductBloc>().add(SearchInventoryProductsEvent(query));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              cardProductList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardProductList() {
  return BlocBuilder<InventoryProductBloc, InventoryProductState>(
    builder: (context, state) {
      if (state is InventoryLoaded) {
        final products = state.products;
        print('======= data product list di screen inventory $products');
        return Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            product.productImg ?? '',
                            height: 120,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: product.productName,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: 'Stock: ${product.stock}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextWidget(
                                        text: 'Price: ${product.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonWidget(
                            buttonColor: Colors.red.shade800,
                            btnWidth: 150,
                            btnHeight: 44,
                            onPressed: () {
                              print('======== klik remove $product, index $index');
                               context
                                    .read<InventoryProductBloc>()
                                    .add(RemoveProductEvent(product.id));
                            },
                            text: 'Delete',
                            icon: Icons.delete,
                            textColor: Colors.white,
                          ),
                          ButtonWidget(
                            text: 'Update',
                            textColor: Colors.white,
                            onPressed: () {
                              context.push(Uri(
                                      path: RouteNames.addProduct,
                                      queryParameters: product.toMap())
                                  .toString());
                            },
                            btnHeight: 44,
                            btnWidth: 150,
                            icon: Icons.edit,
                            buttonColor: Colors.blue.shade900,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      } else if (state is InventoryError) {
        print(state.message);
        return Center(child: Text('Failed to load products.'));
      } else {
        return Container();
      }
    },
  );
}
