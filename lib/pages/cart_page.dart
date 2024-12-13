  import 'package:deliver/Models/resturent.dart';
  import 'package:deliver/components/my_button.dart';
  import 'package:deliver/components/my_cart_tile.dart';
  import 'package:deliver/pages/payment_page.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  class CartPage extends StatelessWidget {
    const CartPage({super.key});

    @override
    Widget build(BuildContext context) {
      return Consumer<Resturent>(
        builder: (context, resturent, child) {
          //carts
          final userCart = resturent.cart;
          return Scaffold(
            appBar: AppBar(
              title: Text("Cart"),
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                //clearning all items
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are You sure You want to clear the cart?'),
                          actions: [
                            //cancel btn
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            //yes btn
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                resturent.clearCart();
                              },
                              child: const Text('Yes'),
                            )
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: Column(
              //list of added carts here
              children: [
                Expanded(
                  child: Column(
                    children: [
                      userCart.isEmpty
                          ? const Expanded(
                              child: Center(child: Text('Cart Is Empty...')))
                          : Expanded(
                              child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                final cartItem = userCart[index];
                  
                                return MyCartTile(cartItem: cartItem);
                              },
                            ))
                    ],
                  ),
                ),
                //paying btn here
                MyButton(onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>const PaymentPage())), text: 'Proceed to bay'),
                const SizedBox(height: 25,)
              ],
            ),
          );
        },
      );
    }
  }
