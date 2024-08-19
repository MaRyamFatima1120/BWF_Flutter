import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/buyer/crat_screen.dart';
import 'package:ecommerce_app/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  final List<String> _carouselImages = [
    "https://i.pinimg.com/originals/32/8f/b5/328fb56c97c824640b31953027962d18.jpg",
    "https://krosskulture.com/cdn/shop/articles/best-girls-dresses-online-shopping-website-in-pakistan-kross-kulture-898545.jpg?v=1689319141",
    "https://styloplanet.com/wp-content/uploads/2021/08/Kross-Kulture-Black-Beyond-Women-Collection-For-Muharram-2021-2022-2-2.jpg",
  ];
  final auth = FirebaseAuth.instance;

  void _signOut() async {
    try {
      await auth.signOut();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error Signout:$e "),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void _addToCart(Product product) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart');

    final query = await cartRef.where('productId', isEqualTo: product.id).get();

    if (query.docs.isEmpty) {
      await cartRef.add({
        'productId': product.id,
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'quantity': 1,
      });
    } else {
      // If already in the cart, update the quantity
      final doc = query.docs.first;
      await cartRef.doc(doc.id).update({
        'quantity': doc['quantity'] + 1,
      });
    }
    // Provide feedback to the user
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${product.name} added to cart'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFdf1b33),
            title: const Text(
              "Ecommerce App",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  try {
                    final userId = FirebaseAuth.instance.currentUser!.uid;

                    // Fetch cart items from Firestore
                    final cartSnapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .collection('cart')
                        .get();

                    // Map Firestore documents to CartItem
                    final cartItems = cartSnapshot.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      // Convert price to double, handling both string and num types
                      final price = data['price'];
                      double parsedPrice;
                      if (price is String) {
                        parsedPrice = double.parse(price);
                      } else if (price is num) {
                        parsedPrice = price.toDouble();
                      } else {
                        throw Exception("Invalid price type");
                      }
                      return CartItem(
                        id: data['productId'],
                        name: data['name'],
                        imageUrl: data['imageUrl'],
                        price: parsedPrice, // Corrected casting
                        quantity: data['quantity'],
                      );
                    }).toList();

                    // Navigate to CartScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(cartItems: cartItems),
                      ),
                    );
                  } catch (e) {
                    // Handle any errors here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error navigating to Cart: $e"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.shopping_cart),
                color: Colors.white,
              ),
              IconButton(
                onPressed: _signOut,
                icon: const Icon(Icons.logout_sharp),
                color: Colors.white,
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder: (context, index, rea) {
                    final imageUrl = _carouselImages[index];
                    return Card(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.9)),
              //Product List
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: const Text(
                  "Product Catlog",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: _productsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  final products = snapshot.data?.docs
                          .map((doc) => Product.fromFirestore(doc))
                          .toList() ??
                      [];

                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 3 / 5),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0)),
                                child: Image.network(product.imageUrl,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Rs.${product.price}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  product.description,
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () {
                                    _addToCart(product);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    backgroundColor: const Color(0xFFdf1b33),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    "Add to Cart ",
                                  )),
                            ],
                          ),
                        );
                      });
                },
              ))
            ],
          )),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Factory constructor to create Product from Firestore document
  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
