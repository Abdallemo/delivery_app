import 'package:deliver/Models/cart_item.dart';
import 'package:deliver/Models/resturent.dart';
import 'package:deliver/components/my_quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Resturent>(
        builder: (context, resturent, child) => Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                              cartItem.food.imagePath,
                              height: 105,
                              width: 105, // Fixed width for the images
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(cartItem.food.name),
                            Text(
                              'RM' + cartItem.food.price.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                        Spacer(),
                        QuantitySelector(
                            food: cartItem.food,
                            onIncrement: () {
                              resturent.addToCart(
                                  cartItem.food, cartItem.selectedAddons);
                            },
                            onDecrement: () {
                              resturent.removeFromCart(cartItem); 
                            },
                            quantity: cartItem.quantity)
                      ],
                    ),
                  ),

                  //addons
                  SizedBox(
                    height: cartItem.selectedAddons.isEmpty ? 0 : 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 10, right: 10),
                      children: cartItem.selectedAddons
                          .map(
                            (addon) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FilterChip(
                                label: Row(
                                  children: [
                                    //name
                                    Text(addon.name),
                                    //price
                                    Text(
                                        ' (+RM' + addon.price.toString() + ')'),
                                  ],
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                onSelected: (value) {},
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ));
  }
}
