import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Your Location"),
      content: const TextField(decoration: InputDecoration(hintText: "Search Address.."),
      ),
      actions: [
        //cancel btn
      MaterialButton(onPressed: ()=>Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      MaterialButton(onPressed: ()=>Navigator.pop(context),
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
                Text("20b,jalan 2 cempaka Biru 84600", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontWeight: FontWeight.bold)),
                  
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
