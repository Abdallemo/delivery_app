import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    var myPrimeTextStyle = TextStyle(color: Theme.of(context).colorScheme.inversePrimary);
    var mySecondaryTextStyle = TextStyle(color: Theme.of(context).colorScheme.primary);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(25),
      margin: EdgeInsets.only(left: 25,right: 25,bottom: 25),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("RM 1.00",style: myPrimeTextStyle),
              Text("Delivery Fee",style: mySecondaryTextStyle,)
            ],
          ),
          Column(
            children: [
              Text("15min - 30 min",style: myPrimeTextStyle,),
              Text("Delivery time",style: mySecondaryTextStyle,)
            ],
          )
        ],
      ),
    );
  }
}