import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screen/buyer/buyer_screen.dart';
import 'package:ecommerce_app/screen/buyer/crat_screen.dart';
import 'package:ecommerce_app/screen/seller/text_form_fied.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final double totalPrice;
  final List<CartItem> cartItems;

  const CheckoutPage({super.key, required this.totalPrice,required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _paymentMethod;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please Enter a valid email address";
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //method
  void _orderPlaceDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Order Placed"),
            content: const Text("Your order has been placed successfully"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const BuyerScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.green),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdf1b33),
        title: const Text(
          "CheckOut",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Order Summary',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Total Price: Rs. ${widget.totalPrice}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  const Text('Shipping Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField2(
                    label: "Name",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField2(
                    label: "Email",
                    controller: _emailController,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 10),
                  TextFormField2(
                    label: "Phone Number",
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField2(
                    label: "Address",
                    maxLines: 2,
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Payment Method',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    items: const [
                      DropdownMenuItem(
                          value: 'Credit Card',
                          child: Text('Credit Card')),
                      DropdownMenuItem(
                          value: 'Cash on Delivery',
                          child: Text('Cash on Delivery')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                    decoration: InputDecoration(
                      label: const Text('Payment Method'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFdf1b33),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a payment method';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          try {
                            final fullName = _nameController.text;
                            final address = _addressController.text;
                            final email = _emailController.text;
                            final contactNumber = _phoneController.text;

                            // Add the order document
                            final orderRef = FirebaseFirestore.instance.collection('orders').doc();
                            final orderId = orderRef.id;

                            await FirebaseFirestore.instance.runTransaction((transaction) async {
                              // Set the order details
                              transaction.set(orderRef, {
                                'buyerName': fullName,
                                'address': address,
                                'email': email,
                                'phoneNumber': contactNumber,
                                'paymentMethod': _paymentMethod,
                                'totalAmount': widget.totalPrice,
                                'status': 'Pending',
                                'createdAt': Timestamp.now(),
                              });

                              // Add order items
                              for (var item in widget.cartItems) {
                                final itemRef = orderRef.collection('orderItems').doc();
                                transaction.set(itemRef, {
                                  'productId': item.id,
                                  'productName': item.name,
                                  'quantity': item.quantity,
                                  'price': item.price,
                                  'imageUrl': item.imageUrl, // Optional, if you want to include the image URL
                                });
                              }
                            });

                            _orderPlaceDialog();
                          } catch (e) {
                            print('Error adding order to Firestore: $e');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Error:$e")));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFdf1b33),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
