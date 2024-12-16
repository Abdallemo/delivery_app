import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/services/database/firestore_services.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  late bool _isloading;
  @override
  void initState() {
    _isloading = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Purchases',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuerySnapshot>(
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
                      List<dynamic> foodItems = (document.data()
                          as Map<String, dynamic>)['foodItems'];

                      //get Orders for each doc
                      return Card(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('Order ID: ${document.id}'),
                              SizedBox(height: 10),

                              ...foodItems.map((item) {
                                String foodName = (item)['name'];
                                int quantity = (item)['quantity'];
                                double price = (item)['price'];
                                String imagePath = (item)['imagePath'];
                                List selectedAddons = (item)['selectedAddons'];

                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            imagePath,
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                foodName,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Quantixi + ( x ${quantity.toString()})',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [Text('Total ')],
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
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
