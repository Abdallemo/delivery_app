import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference orders = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Orders");
      
  final CollectionReference cart = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Cart");

  // Save order to Firestore with additional fields (name, price, image, etc.)
  Future<void> saveOrdersToDatabase(String receipt, List<Map<String, dynamic>> foodItems,double totalPrice) async {
    try {
      await orders.add({
        'date': DateTime.now(),
        'order': receipt,
        'foodItems': foodItems,
        'totalPrice': totalPrice,
        
      });
      print("Order saved to Firestore");
    } catch (e) {
      print("Error saving order: $e");
    }
  }

  // Fetch Cart and generate receipt, also prepare food items for order
  Future<Map<String, dynamic>> generateReceiptFromCart() async {
    String receipt = "Receipt:\n";
    double total = 0;
    List<Map<String, dynamic>> foodItems = [];

    try {
      QuerySnapshot cartSnapshot = await cart.get();
      for (var doc in cartSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        String foodName = data['food']['name'];
        int quantity = data['quantity'];
        double foodPrice = data['food']['price'];
        String imagePath = data['food']['imagePath'];
        List selectedAddons = data['selectedAddons'];

        receipt += "$foodName (x$quantity)\n";

        // Add the food item to the list of food items for the order
        foodItems.add({
          'name': foodName,
          'quantity': quantity,
          'price': foodPrice,
          'imagePath': imagePath,
          'selectedAddons':selectedAddons
        });

        // Calculate price for selected addons
        double addonPrice = 0;
        for (var addon in selectedAddons) {
          receipt += " - Addon: ${addon['name']} (Price: ${addon['price']})\n";
          addonPrice += addon['price'];
        }

        // Calculate the total price for this item (food + addons)
        double itemTotal = (foodPrice * quantity) + addonPrice;
        total += itemTotal;

        receipt += "Total for this item: $itemTotal\n";
      }

      receipt += "\nGrand Total: $total";

      return {
        'receipt': receipt,
        'foodItems': foodItems,
        'totalPrice': total,
      };
    } catch (e) {
      print("Error fetching cart data: $e");
      return {'receipt': "Error generating receipt."};
    }
  }

  // Clear the cart after saving the order
  Future<void> clearCart() async {
    try {
      QuerySnapshot cartSnapshot = await cart.get();
      for (var doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }
      print("Cart cleared.");
    } catch (e) {
      print("Error clearing cart: $e");
    }
  }
  
  Stream<QuerySnapshot> getOrdersFromFirebase(){
    final orderStream = orders.orderBy('date',descending:true).snapshots();
    return orderStream;

  }
}
