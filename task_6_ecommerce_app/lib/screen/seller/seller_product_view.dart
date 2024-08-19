import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/seller/edit_product_screen.dart';
import 'package:flutter/material.dart';

class SellerProductView extends StatefulWidget {
  const SellerProductView({super.key});

  @override
  State<SellerProductView> createState() => _SellerProductViewState();
}

class _SellerProductViewState extends State<SellerProductView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final Stream<QuerySnapshot> _productStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productStream = _firestore.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdf1b33),
        centerTitle: true,
        title:
            const Text("Product View", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products available.'));
          }
          final products = snapshot.data!.docs;
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.67,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5.0)),
                          child: Image.network(
                            product['imageUrl'],
                            fit: BoxFit.cover,
                          ),
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Text(
                                ' PKR ${product['price']}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                product['description'],
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        ButtonBar(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProductScreen(
                                                productId: products[index].id,
                                                productPrice: product['price'],
                                                productName: product['name'],
                                                productDescription:
                                                    product['description'],
                                                productImageUrl:
                                                    product['imageUrl'],
                                              )));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(products[index].id)
                                        .delete();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Delete Product Successfully"),
                                    ));
                                  } catch (e) {
                                    print("Failed to delete product:$e");
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Failed to delete Product "),
                                    ));
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
