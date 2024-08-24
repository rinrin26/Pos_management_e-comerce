import 'dart:math';

import 'package:final_project_application_pos/UI/widget/alert_dialog_widget.dart';
import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_field_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_widget.dart';
import 'package:final_project_application_pos/bloc/cubit_img/images_cubit.dart';
import 'package:final_project_application_pos/bloc/inventory_product_bloc/inventory_product_bloc.dart';
import 'package:final_project_application_pos/model/inventory_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  final InventoryProductModel? product;
  const AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController _productNameController;
  late TextEditingController _skuController;
  late TextEditingController _priceController;
  late TextEditingController _productImageController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _genderController;
  late TextEditingController _stockController;
  late String imgProduct;

  @override
  void initState() {
    super.initState();
    _productNameController =
        TextEditingController(text: widget.product?.productName ?? '');
    _skuController = TextEditingController(text: widget.product?.sku ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price.toString() ?? '');
    _productImageController =
        TextEditingController(text: widget.product?.productImg ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _categoryController =
        TextEditingController(text: widget.product?.category ?? '');
    _genderController =
        TextEditingController(text: widget.product?.gender ?? '');
    _stockController =
        TextEditingController(text: widget.product?.stock.toString() ?? '');
    imgProduct = widget.product?.productImg ?? '';
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _skuController.dispose();
    _categoryController.dispose();
    _genderController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _productImageController.dispose();
    _stockController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    final randomId = uuid.v4();

    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: widget.product != null ? 'Update Product' : 'Add Product',
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: ListView(
          children: [
            const TextWidget(
              text: 'Product Name',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const TextWidget(
              text:
                  'Do not exceed 20 characters when entering the product name',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            TextFieldWidget(
              hintText: 'enter product name',
              controller: _productNameController,
              usePrimaryDecoration: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'SKU',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const TextWidget(
              text:
                  'SKU is scannable barcode and is the unit of measure in wich the stock of a product is managed',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            TextFieldWidget(
              hintText: 'enter SKU',
              controller: _skuController,
              usePrimaryDecoration: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Pricing',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            TextFieldWidget(
              hintText: '000',
              controller: _priceController,
              prefixIconText: Icons.attach_money,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Stock',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            TextFieldWidget(
              hintText: '10',
              controller: _stockController,
              usePrimaryDecoration: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Category',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const TextWidget(
              text:
                  'Please select your product category from the list provided.',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            TextFieldWidget(
              hintText: 'category',
              controller: _categoryController,
              usePrimaryDecoration: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Gender',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const TextWidget(
              text: 'Set the gender for this product.',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            TextFieldWidget(
              hintText: 'Select gender',
              controller: _genderController,
              usePrimaryDecoration: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Photo Product',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const TextWidget(
              text:
                  'Recomendation minimum width 1080px X 1080px, with a max size of 5MB, only*.jpg, .PNG, and .jpeg image are accepted',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            addImage(productId: randomId),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Product Description',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const TextWidget(
              text:
                  'Set a description on product to detail your product and better visibility',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            TextFieldWidget(
              hintText: 'description',
              controller: _descriptionController,
              usePrimaryDecoration: true,
              height: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              text: 'Save Product',
              onPressed: () {
                final prices = double.tryParse(_priceController.text) ?? 0.0;
                final stock = int.tryParse(_stockController.text) ?? 0;

                final dataProduct = InventoryProductModel(
                  id: randomId,
                  productName: _productNameController.text,
                  sku: _skuController.text,
                  price: prices,
                  description: _descriptionController.text,
                  category: _categoryController.text,
                  gender: _genderController.text,
                  productImg: context.read<ImagesCubit>().state.linkGambar,
                  stock: stock,
                );

                //save product
                context
                    .read<InventoryProductBloc>()
                    .add(AddInventoryProduct(product: dataProduct));
                const SnackBar(
                  content: Text('data has been added to products'),
                  duration: Duration(seconds: 2),
                );
              },
              icon: Icons.save,
              buttonColor: Colors.blue.shade800,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget addImage({required String productId}) {
    return BlocBuilder<ImagesCubit, ImagesState>(builder: (context, state) {
      return Container(
        width: 160,
        height: 240,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.upload,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonWidget(
                text: state.isLoading ? 'uploading ...' : 'Add Image',
                onPressed: () async {
                  pickImage(productId);
                },
                btnWidth: 180,
                btnHeight: 50,
                buttonColor: Colors.blue.shade800,
                textColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'or drop image to upload',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextWidget(
                text: imgProduct,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (state.linkGambar != null)
                TextWidget(
                  text: 'Image uploaded successfully!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.green,
                      ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> pickImage(String productId) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print('==========data id di pickImage ===== ${productId}');

    if (image?.path != null) {
      context
          .read<ImagesCubit>()
          .uploadImage(path: image!.path, productId: productId);
    }
  }
}
