// ignore_for_file: prefer_const_constructors

// import 'package:deliver/components/my_reciept.dart';
import 'package:deliver/services/database/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage>
    with TickerProviderStateMixin {
  FirestoreService db = FirestoreService();
  late final AnimationController _controller;
  bool _animationCompleted = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // Generate receipt and get food items and total price
        var receiptData = await db.generateReceiptFromCart();

        // Extract receipt, food items, and total price from the response
        String receipt = receiptData['receipt'];
        List<Map<String, dynamic>> foodItems = receiptData['foodItems'];
        double totalPrice = receiptData['totalPrice'];

        // Save the order with the new data
        await db.saveOrdersToDatabase(receipt, foodItems, totalPrice);

        // Clear the cart after the order is saved
        await db.clearCart();

        print("Order processed successfully");
      } catch (e) {
        print("Error processing order: $e");
      }
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _animationCompleted = true;
          });
          // Add a delay before navigating
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamed(context, '/homepage');
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery in Progress..."),
        leading: IconButton(
            onPressed: () async {
              // Navigator.of(context)..pop()..pop()..pop()..pop();
              Navigator.pushNamed(context, '/homepage');
            },
            icon: const Icon(Icons.home)),
      ),
      // bottomNavigationBar: _buildBottomNavBar(context),
      body: SafeArea(
        child: Center(
          child: Visibility(
            visible: !_animationCompleted,
            child: Lottie.asset(
              "assets/animations/done.json",
              width: 600,
              controller: _controller,
              onLoaded: (composition) {
                _controller.forward(); // Starts the animation
              },
            ),
          ),
        ),
      ),
    );
  }

  //mycustome for driver
//   Widget _buildBottomNavBar(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.secondary,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40), topRight: Radius.circular(40))),
//       padding: const EdgeInsets.all(25),
//       child: Row(
//         children: [
//           //driver profile pcis
//           Container(
//             decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surface,
//                 shape: BoxShape.circle),
//             child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
//           ),

//           SizedBox(
//             width: 10,
//           ),
//           //driver detaisl
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Hafiz Bin Mohd",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Theme.of(context).colorScheme.inversePrimary),
//               ),
//               Text(
//                 "Driver",
//                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
//               ),
//             ],
//           ),
//           const Spacer(),

//           Row(
//             children: [
//               //mssg btn
//               Container(
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.surface,
//                     shape: BoxShape.circle),
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.message,
//                       color: Theme.of(context).colorScheme.primary,
//                     )),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               //call btn
//               Container(
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.surface,
//                     shape: BoxShape.circle),
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.call,
//                       color: Colors.green,
//                     )),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
}
