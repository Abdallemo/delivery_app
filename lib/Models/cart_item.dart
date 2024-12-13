import 'package:deliver/Models/food.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
    required this.selectedAddons,
  });

  double get totalPrice {
    double addonPrice =
        selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (food.price + addonPrice) * quantity;
  }

  // Convert CartItem to a Map
  Map<String, dynamic> toMap() {
    return {
      'food': food.toMap(),  // Convert Food object to map
      'selectedAddons': selectedAddons.map((addon) => addon.toMap()).toList(),  // Convert Addon objects to maps
      'quantity': quantity,
    };
  }

  // Create a CartItem from a Map
  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      food: Food.fromMap(map['food']),  // Convert map to Food object
      selectedAddons: List<Addon>.from(map['selectedAddons'].map((addonMap) => Addon.fromMap(addonMap))),  // Convert map to Addon objects
      quantity: map['quantity'] ?? 1,
    );
  }
}
