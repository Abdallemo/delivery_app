import 'package:deliver/Models/resturent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  MyCurrentLocation({super.key});

  final textController = TextEditingController();
  void openLocationSearchBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Your Location"),
              content: TextField(
                controller: textController,
                decoration: InputDecoration(hintText: "Enter Address.."),
              ),
              actions: [
                //cancel btn
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    String newAddress = textController.text;
                    context.read<Resturent>().updatedDeliveryAddres(newAddress);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),

                //save btn
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                Consumer<Resturent>(
                    builder: (context, resturent, child) => Text(
                        resturent.deliveryAddress,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold))),

                //drop down icon i guss
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          )
        ],
      ),
    );
  }
}
