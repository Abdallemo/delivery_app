import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final child;
  const EventCard({super.key,required this.isPast,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
      
      decoration: BoxDecoration(
        color: isPast ? Colors.deepPurple:Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}