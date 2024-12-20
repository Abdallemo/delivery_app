import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/Models/resturent.dart';
import 'package:deliver/pages/location_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  MyCurrentLocation({super.key});

  final textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LocationPage())),
            child: Row(
              children: [
                StreamBuilder<QuerySnapshot>(
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
                      final userData = snapshot.data!.docs.first.data()
                          as Map<String, dynamic>;
                      final location = userData['location'] ??
                          'No location set'; // Default text if no location

                      return Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return Text(
                          'No location found'); // Fallback text if no location exists
                    }
                  },
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
