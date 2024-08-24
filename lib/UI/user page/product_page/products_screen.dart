import 'package:final_project_application_pos/UI/user%20page/product_page/product_page.dart';
import 'package:final_project_application_pos/UI/widget/filter_chip_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_field_widget.dart';
import 'package:final_project_application_pos/bloc/product_bloc/product_bloc.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue.shade900,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Builder(
              builder: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFieldWidget(
                      controller: searchController,
                      hintText: 'Search',
                      suffixIcon: Icons.search,
                      usePrimaryDecoration: true,
                      filled: true,
                      fillColor: Colors.white,
                      width: 280,
                      onChanged: (query) {
                        context
                            .read<ProductBloc>()
                            .add(SearchProductsEvent(query));
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      children: [
                        FilterChipWidget(
                          label: 'electronics',
                          onSelected: (bool value) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChipWidget(
                          label: 'jewelery',
                          onSelected: (bool value) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChipWidget(
                          label: 'mens clothing',
                          onSelected: (bool value) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChipWidget(
                          label: 'womens clothing',
                          onSelected: (bool value) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChipWidget(
                          label: 'Option 5',
                          onSelected: (bool value) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChipWidget(
                          label: 'Option 6',
                          onSelected: (bool value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.push(RouteNames.cart);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chat_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: const ProductPage(),
    );
  }
}
