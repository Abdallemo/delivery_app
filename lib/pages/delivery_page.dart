import 'package:deliver/components/my_timeline_tile.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Purchases',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: ListView(
          children: const [
            //start timeline
            MyTimelineTile(
              isFirst: true,
              isLast: false,
              isPast: true,
              eventCard: Text('ORDER PLACED'),
            ),
            //middle time line

            MyTimelineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: Text('ORDER SHIPPED'),
            ),
            //end time line

            MyTimelineTile(
              isFirst: false,
              isLast: true,
              isPast: false,
              eventCard: Text('ORDER DELIVERED'),
            )
          ],
        ),
      ),
    );
  }
}
