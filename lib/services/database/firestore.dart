// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirestoreServices {
//   final CollectionReference orders = FirebaseFirestore.instance
//       .collection('Users')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection("Orders");

//   //save orders to db

//   Future<void> saveOrdersToDatabase(String receipt) async {
//     try{
//     await orders.add({
//       'date': DateTime.now(),
//       'order': receipt,
//     });
//      print("Order saved to Firestore");
//     }catch(e)
//     {
//       print("Error saving order: $e");
//     }
//   }
// }
