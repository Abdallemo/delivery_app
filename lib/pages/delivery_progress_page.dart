// ignore_for_file: prefer_const_constructors

// import 'package:deliver/components/my_reciept.dart';
import 'package:deliver/components/my_notification.dart';
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

        Future.delayed(const Duration(seconds: 1), () async {
          await NotificationHelper.showNotification(
            id: 1,
            title: 'Order Completed',
            body: 'Your order has been successfully placed!',
            channelId: 'order_channel',
            channelName: 'Order Notifications',
          );
        });
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
          Future.delayed(const Duration(microseconds: 300), () {
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
        automaticallyImplyLeading: false,
        centerTitle: true,
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
}
