import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/components/payment_options_tile.dart';
import 'package:deliver/pages/delivery_progress_page.dart';
import 'package:deliver/pages/location_page.dart';
import 'package:deliver/pages/payment_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final CollectionReference profile = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Profile");

  String? location;

  String? selectedPaymentOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Out'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLocationStream(),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [buildCartStream()],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                PaymentOptionsTile(
                  paymentOptions: ['MasterCard', 'Cash'],
                  selectedPaymentOption: selectedPaymentOption,
                  onPaymentOptionChanged: (value) {
                    setState(() {
                      selectedPaymentOption = value;
                    });
                  },
                  onProceed: () {
                    if (selectedPaymentOption == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Please select a payment method.")),
                      );
                    } else {
                      if (selectedPaymentOption == "MasterCard") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPage()));
                      } else if (selectedPaymentOption == "Cash") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryProgressPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("You selected: $selectedPaymentOption")),
                        );
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

StreamBuilder<QuerySnapshot> buildLocationStream() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Profile")
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Loading indicator
      }

      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
        final userData =
            snapshot.data!.docs.first.data() as Map<String, dynamic>;
        final location = userData['location'] ?? 'No location set';
        final username = userData['username'];

        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  username,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 18),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 14),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationPage())),
                        child: Icon(Icons.keyboard_arrow_right_outlined))
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Text('No location found'); // Fallback text if no location exists
      }
    },
  );
}

StreamBuilder<QuerySnapshot> buildCartStream() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Cart')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
            child: CircularProgressIndicator()); // Loading indicator
      }

      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
        final cartItems = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          // Extracting the data fields
          final String foodName = data['food']['name'] ?? 'Unknown';
          final int quantity = data['quantity'] ?? 1;
          final double foodPrice = (data['food']['price'] ?? 0.0).toDouble();
          final String imagePath = data['food']['imagePath'] ?? '';
          final List<dynamic> selectedAddons = data['selectedAddons'] ?? [];
          final double addonsPrice = selectedAddons.isNotEmpty
              ? selectedAddons.fold(0.0, (sum, addon) {
                  return sum +
                      (addon['price'] ??
                          0.0); // Sum the prices of selected add-ons
                })
              : 0.0;
          final double totalFoodPrice = (foodPrice + addonsPrice) * quantity;
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
              ),
              title: Text(foodName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: RM${foodPrice.toString()} x $quantity',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Add-ons: ${selectedAddons.isNotEmpty ? selectedAddons.map((addon) => addon['name']).join(', ') : 'None'}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: Text(
                '\$${((foodPrice + addonsPrice) * quantity).toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList();

        // Returning a column of cart item cards
        return Column(
          children: cartItems,
        );
      } else {
        return Text(
            'No items in cart'); // Fallback text if no items in the cart
      }
    },
  );
}
