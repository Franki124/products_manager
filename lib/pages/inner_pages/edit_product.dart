import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:products_manager/pages/widgets/label_text_field_widget.dart';

import '../../blocs/product_blocs.dart';
import '../../blocs/product_events.dart';
import '../../models/product.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _AddProductState();
}

class _AddProductState extends State<EditProductPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(text: widget.product.price?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Edit Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              LabelTextField(
                inputType: TextInputType.text,
                defaultText: 'Product Name',
                controller: nameController,
              ),
              const Gap(20),
              LabelTextField(
                inputType: TextInputType.number,
                defaultText: 'Product price',
                controller: priceController,
              ),
              TextButton(
                onPressed: () {
                  String newName = nameController.text;
                  int? newPrice = int.tryParse(priceController.text);
                  List<Map<String, String>> updatedHistory = List.from(widget.product.history ?? []);
                  String updateDetails = 'Updated ';

                  if (newName != widget.product.name) {
                    updateDetails += 'name, ';
                  }
                  if (newPrice != widget.product.price) {
                    updateDetails += 'price, ';
                  }
                  updateDetails = updateDetails.substring(0, updateDetails.length - 2);

                  updatedHistory.add(Product.createHistoryEntry('Updated', updateDetails));

                  Product updatedProduct = Product(
                    id: widget.product.id,
                    name: newName,
                    price: newPrice,
                    history: updatedHistory,
                  );

                  BlocProvider.of<ProductsBloc>(context).add(
                    UpdateProductEvent(updatedProduct),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
