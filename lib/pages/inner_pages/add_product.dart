import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:products_manager/pages/widgets/label_text_field_widget.dart';

import '../../blocs/product_blocs.dart';
import '../../blocs/product_events.dart';
import '../../models/product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductState();
}

class _AddProductState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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
          'Add Product',
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
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
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
                defaultText: 'Product Price',
                controller: priceController,
              ),
              TextButton(
                onPressed: () {
                  int? price = int.tryParse(priceController.text);
                  String name = nameController.text;

                  Product newProduct = Product(
                    name: name,
                    price: price,
                    history: [Product.createHistoryEntry('Created', 'Initial creation')],
                  );
                  BlocProvider.of<ProductsBloc>(context).add(
                    CreateProductEvent(newProduct),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
