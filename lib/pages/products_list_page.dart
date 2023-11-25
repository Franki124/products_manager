import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:products_manager/pages/inner_pages/add_product.dart';

import '../models/product.dart';
import 'inner_pages/edit_product.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Product Manager',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: 200.w,
        height: 400.h,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: StreamBuilder<QuerySnapshot>(
          stream: _productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade900,
                ),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No products yet ;D',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final productsData = snapshot.data!.docs[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 14, left: 10, right: 10),
                    child: Slidable(
                        key: const ValueKey(0),
                        startActionPane: ActionPane(
                          extentRatio: 0.26,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                String documentId =
                                    snapshot.data!.docs[index].id;

                                var documentSnapshot = await _firestore
                                    .collection('products')
                                    .doc(documentId)
                                    .get();
                                if (documentSnapshot.exists && mounted) {
                                  Map<String, dynamic> data = documentSnapshot
                                      .data() as Map<String, dynamic>;

                                  List<Map<String, String>> history;
                                  if (data['history'] != null) {
                                    history = List<Map<String, String>>.from(
                                        data['history'].map((item) =>
                                            Map<String, String>.from(item)));
                                  } else {
                                    history = [];
                                  }

                                  Product product = Product(
                                    id: documentId,
                                    name: data['name'],
                                    description: data['description'],
                                    price: data['price'],
                                    history: history,
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProductPage(product: product)),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            const Gap(10),
                          ],
                        ),
                        endActionPane: ActionPane(
                          extentRatio: 0.26,
                          motion: const ScrollMotion(),
                          children: [
                            const Gap(10),
                            SlidableAction(
                              onPressed: (context) async {
                                String documentId =
                                    snapshot.data!.docs[index].id;
                                await _firestore
                                    .collection('products')
                                    .doc(documentId)
                                    .delete();
                              },
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Container(
                          width: 200.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlueAccent.shade100
                                .withOpacity(0.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  productsData['name'],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  '\$ ${productsData['price']}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddProductPage();
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
