import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFcmApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();

    final FCMToken = await _firebaseMessaging.getToken();

    print('Token:$FCMToken');
  }
}