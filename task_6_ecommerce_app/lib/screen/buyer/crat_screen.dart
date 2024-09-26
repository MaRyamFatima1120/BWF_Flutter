import 'package:ecommerce_app/screen/buyer/checkout_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = List.from(
        widget.cartItems); // Use List.from to avoid modifying the original list
  }

  void _removeItem(int index) {
    setState(() {
      // If the quantity is greater than 1, decrease the quantity
      if (_cartItems[index].quantity > 1) {
        _cartItems[index] = CartItem(
          id: _cartItems[index].id,
          name: _cartItems[index].name,
          imageUrl: _cartItems[index].imageUrl,
          price: _cartItems[index].price,
          quantity: _cartItems[index].quantity - 1,
        );
      } else {
        // If the quantity is 1, remove the item from the cart
        _cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdf1b33),
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = _cartItems[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Image.network(
                              cartItem.imageUrl,
                              height: 50,
                              width: 50,
                            ),
                            title: Text(
                              cartItem.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Quantity: ${cartItem.quantity}'),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs. ${cartItem.price * cartItem.quantity}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          _removeItem(index);
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          size: 18,
                                          color: Colors.red,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: Rs. $totalPrice',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutPage(totalPrice: totalPrice, cartItems: _cartItems,),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFdf1b33),
                        ),
                        child: const Text('Proceed to Checkout',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
