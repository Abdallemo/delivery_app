import 'package:deliver/Models/resturent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For formatting time
class MyReciept extends StatelessWidget {
  const MyReciept({super.key});
  

  @override

  Widget build(BuildContext context) {
        // Calculate the estimated delivery time
    DateTime now = DateTime.now();
    DateTime estimatedTime = now.add(const Duration(minutes: 20));
    String formattedTime = DateFormat.jm().format(estimatedTime);
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25,top: 50),
      child: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Thank You for Your Order!"),
            const SizedBox(height: 25,),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(25),
              child: Consumer<Resturent>(builder: (context,resturent,child)=>Text(resturent.displayCartReceipt()),),
            ),
            const SizedBox(height: 25,),
            Text("Estimated Delivery Time is $formattedTime"),
          ],
        ),
      ),
    );
  }
}
