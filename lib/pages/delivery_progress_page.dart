import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/Models/resturent.dart';
import 'package:deliver/components/my_reciept.dart';
import 'package:deliver/pages/home_page.dart';
import 'package:deliver/services/database/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resturent = context.read<Resturent>();

      String receipt = resturent.displayCartReceipt();
      db.saveOrdersToDatabase(receipt);
      resturent.clearCart();
    });
  }

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
    print('User UID: $userUid');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery in Progress..."),
        leading: IconButton(
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
              final snapshots = await cartCollection.get();
              for (var doc in snapshots.docs) {
                await doc.reference.delete();
              }
            },
            icon: const Icon(Icons.home)),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: const Column(
        children: [
          MyReciept(),
        ],
      ),
    );
  }

  //mycustome for driver
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          //driver profile pcis
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          ),

          SizedBox(
            width: 10,
          ),
          //driver detaisl
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hafiz Bin Mohd",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text(
                "Driver",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const Spacer(),

          Row(
            children: [
              //mssg btn
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              //call btn
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
