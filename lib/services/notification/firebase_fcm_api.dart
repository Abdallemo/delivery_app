import 'package:deliver/components/my_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFcmApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final FCMToken = await _firebaseMessaging.getToken();
    await _firebaseMessaging.subscribeToTopic('all_users');
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      NotificationHelper.showNotification(
          id: notification.hashCode,
          title: notification.title.toString(),
          body: notification.body.toString());
    });

    print('Token:$FCMToken');
  }
}
