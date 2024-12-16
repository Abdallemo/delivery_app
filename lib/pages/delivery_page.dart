import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/services/database/firestore_services.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Purchases',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService().getOrdersFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List orderList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  // here getting individual items
                  DocumentSnapshot document = orderList[index];
                  String docId = document.id;
                  List<dynamic> foodItems =
                      (document.data() as Map<String, dynamic>)['foodItems'];
                  //get Orders for each doc
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Order ID: ${document.id}'),
                        ...foodItems.map((item) {
                          String foodName = (item)['name'];
                          int quantity = (item)['quantity'];
                          double price = (item)['price'];
                          String imagePath = (item)['imagePath'];

                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.asset(imagePath, width: 50, height: 50),
                                SizedBox(width: 10,),
                                Text(
                                    'Item: $foodName, Qty: $quantity, Price: $price'),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );

                  //display a list of orders
                },
              );
            } else {
              return const Text("No Orders....");
            }
          }),
    );
  }
}
