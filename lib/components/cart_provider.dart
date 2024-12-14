import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CartProvider with ChangeNotifier {
  Map<String, dynamic> cartData = {};

  // Fetch cart data from Firestore
  Future<void> fetchCartData(String userId) async {
    try {
      final cartRef = FirebaseFirestore.instance.collection('Users').doc(userId).collection('Cart');
      final snapshot = await cartRef.get();
      cartData = {
        for (var doc in snapshot.docs) doc.id: doc.data(),
      };
      notifyListeners();
    } catch (e) {
      print("Error fetching cart data: $e");
    }
  }

  // Method to add an item to the cart
  Future<void> addToCart(String userId, Map<String, dynamic> cartItem) async {
    try {
      final cartRef = FirebaseFirestore.instance.collection('Users').doc(userId).collection('Cart');
      await cartRef.add(cartItem);  // Add item to Firestore Cart collection
      cartData[cartItem['id']] = cartItem;  // Add item to local cart state
      notifyListeners();
    } catch (e) {
      print("Error adding item to cart: $e");
    }
  }

  // Method to update quantity of an item
  Future<void> updateQuantity(String userId, String cartItemId, int newQuantity) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Cart') // Corrected path here
          .doc(cartItemId)
          .update({'quantity': newQuantity});
      
      cartData[cartItemId]['quantity'] = newQuantity;
      notifyListeners();
    } catch (e) {
      print("Error updating quantity: $e");
    }
  }

  // Method to remove an item from the cart
  Future<void> removeFromCart(String userId, String cartItemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Cart') 
          .doc(cartItemId)
          .delete();
      
      cartData.remove(cartItemId);  // Remove item from local state
      notifyListeners();
    } catch (e) {
      print("Error removing item from cart: $e");
    }
  }
}
