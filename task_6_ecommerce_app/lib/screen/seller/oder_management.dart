import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdf1b33),
        title: const Text(
          "Order Management",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
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

          final orders = snapshot.data?.docs ?? [];

          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders found'),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final orderData = orders[index].data() as Map<String, dynamic>;

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Center(
                      child: Text(
                    'Order ID: ${orders[index].id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(TextSpan(children: [
                            const TextSpan(
                                text: 'Buyer Name:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${orderData['buyerName']}')
                          ])),
                          Text(
                            '${orderData['status']}',
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'Payment:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${orderData['paymentMethod']}')
                      ])),
                      Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'Email:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${orderData['email']}')
                      ])),
                      Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'Phone Number:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${orderData['phoneNumber']}')
                      ])),
                      Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'Address:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${orderData['address']}')
                      ])),
                      Center(
                        child: Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: 'Total:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: 'Rs.${orderData['totalAmount']} ',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ])),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(
                                orderId: orders[index].id,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFdf1b33),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'View Order Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdf1b33),
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId)
            .collection('orderItems')
            .snapshots(),
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

          final orderItems = snapshot.data?.docs ?? [];

          if (orderItems.isEmpty) {
            return const Center(
              child: Text('No items found in this order'),
            );
          }

          return ListView.builder(
            itemCount: orderItems.length,
            itemBuilder: (context, index) {
              final itemData = orderItems[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10.0),
                color: Colors.white,
                child: ListTile(
                  leading: Image.network(itemData['imageUrl']),
                  title: Text(itemData['productName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${itemData['quantity']}'),
                      Text('Price: Rs.${itemData['price']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
