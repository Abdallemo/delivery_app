import 'package:deliver/Models/resturent.dart';
import 'package:deliver/components/my_reciept.dart';
import 'package:deliver/services/database/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {

  FirestoreService db = FirestoreService();

  @override
  void initState(){
    super.initState();

    String receipt = context.read<Resturent>().displayCartReceipt();
    db.saveOrdersToDatabase(receipt);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery in Progress..."),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: const Column(
        children: [
          MyReciept(),
        ],
      ),
    );
  }

  //mycustome for driver
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          //driver profile pcis
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          ),

          SizedBox(
            width: 10,
          ),
          //driver detaisl
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hafiz Bin Mohd",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text(
                "Driver",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const Spacer(),

          Row(
            children: [
              //mssg btn
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.message,color: Theme.of(context).colorScheme.primary,)),
              ),
              const SizedBox(width: 10,),
              //call btn
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.call,color: Colors.green,)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
