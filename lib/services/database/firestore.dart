import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('Orders');

      //save orders to db 

      Future<void> saveOrdersToDatabase(String receipt) async{
        await orders.add({
          'date':DateTime.now(),
          'order':receipt,
        });
      }
}
