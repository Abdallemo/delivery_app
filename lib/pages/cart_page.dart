import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/components/my_cart_tile.dart';
import 'package:deliver/components/my_button.dart';
import 'package:deliver/pages/checkout.dart';
import 'package:deliver/services/database/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }
    final userUid = user.uid;
    final cartCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(userUid)
        .collection('Cart');
         final firestoreService = FirestoreService();
    print('User UID: $userUid');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Clearing all items
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are You sure You want to clear the cart?'),
                  actions: [
                    // Cancel button
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    // Yes button
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await firestoreService.clearCart();
                      },
                      child: const Text('Yes'),
                    )
                  ],
                ),
              );
            },
            icon: Image.asset('assets/flattIcon/delete.png', width: 24.0,color: Theme.of(context).colorScheme.inversePrimary),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Cart Is Empty...'));
          }

          final cartItems = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItemDoc = cartItems[index];
                    return MyCartTile(cartItemDoc: cartItemDoc);
                  },
                ),
              ),
              MyButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Checkout()),
                ),
                text: 'Proceed to Pay',
              ),
              const SizedBox(height: 25),
            ],
          );
        },
      ),
    );
  }
}
