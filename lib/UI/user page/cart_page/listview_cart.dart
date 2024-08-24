import 'package:final_project_application_pos/bloc/cart_bloc/cart_bloc.dart';
import 'package:final_project_application_pos/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewWidget extends StatefulWidget {
  final List<ProductModel> data;
  final double? iconSize;

  const ListViewWidget({
    super.key,
    required this.data,
    this.iconSize,
  });

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  int _quantity = 1;

  void _increaseQuantity(ProductModel product) {
    setState(() {
      _quantity++;
      context
          .read<CartBloc>()
          .add(UpdateProductQuantity(product.id, _quantity));
    });
  }

  void _decreaseQuantity(ProductModel product) {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        context
            .read<CartBloc>()
            .add(UpdateProductQuantity(product.id, _quantity));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: widget.data.length,
      itemBuilder: (context, int index) {
        final item = widget.data[index];

        return Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              leading: Expanded(
                child: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.category,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: ${item.price.toString()}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      buttonAddMinQuantity(product: item)
                    ],
                  )
                ],
              ),
              onTap: () {},
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  buttonAddMinQuantity({required ProductModel product}) {
    return Row(
      children: [
        IconButton(
            onPressed: () => {_decreaseQuantity(product)},
            icon: const Icon(Icons.minimize_rounded)),
        Text(
          _quantity.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(
          width: 5,
        ),
        IconButton(
            onPressed: () => {_increaseQuantity(product)}, icon: const Icon(Icons.add)),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

}
