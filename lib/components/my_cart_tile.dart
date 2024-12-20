import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver/components/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deliver/Models/food.dart';
import 'package:deliver/components/my_quantity_selector.dart';

class MyCartTile extends StatelessWidget {
  final QueryDocumentSnapshot cartItemDoc;

  const MyCartTile({super.key, required this.cartItemDoc});

  @override
  Widget build(BuildContext context) {
    final cartData = cartItemDoc.data() as Map<String, dynamic>;

    // Accessing the 'food' field
    final foodData = cartData['food'] as Map<String, dynamic>;
    final food = Food(
      name: foodData['name'] ?? 'Unknown',
      price: foodData['price'] ?? 0.0,
      imagePath: foodData['imagePath'] ?? '',
      description: foodData['description'] ?? '',
      availableAddons: (foodData['availableAddons'] as List<dynamic>? ?? [])
          .map((addon) => Addon(
                name: addon['name'],
                price: addon['price'],
              ))
          .toList(),
    );

    final quantity = cartData['quantity'] ?? 1;
    final selectedAddons = (cartData['selectedAddons'] as List<dynamic>? ?? [])
        .map((addon) => Addon(name: addon['name'], price: addon['price']))
        .toList();

    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        final userId = FirebaseAuth.instance.currentUser?.uid; 

        if (userId == null) {
          
          return Center(child: Text('Please log in to view your cart.'));
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        food.imagePath,
                        height: 105,
                        width: 105,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name),
                        Text(
                          'RM${food.price.toString()}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    QuantitySelector(
                      food: food,
                      onIncrement: () {
                        cartProvider.updateQuantity(
                          userId, 
                          cartItemDoc.id, 
                          quantity + 1, 
                        );
                      },
                      onDecrement: () {
                        if (quantity > 1) {
                          cartProvider.updateQuantity(
                            userId, 
                            cartItemDoc.id, 
                            quantity - 1, 
                          );
                        } else {
                          cartProvider.removeFromCart(
                            userId, 
                            cartItemDoc.id, 
                          );
                        }
                      },
                      quantity: quantity,
                    ),
                  ],
                ),
              ),

              // Addons
              SizedBox(
                height: selectedAddons.isEmpty ? 0 : 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  children: selectedAddons
                      .map(
                        (addon) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Row(
                              children: [
                                Text(addon.name),
                                Text(' (+RM${addon.price.toString()})'),
                              ],
                            ),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onSelected: (value) {},
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
