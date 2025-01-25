import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfig {
  static FirebaseOptions get android {
    return FirebaseOptions(
      apiKey: dotenv.env['ANDROID_FIREBASE_API_KEY']!,
      appId: '1:500358298980:android:8593077870c36572f28e71',
      messagingSenderId: '500358298980',
      projectId: 'mad-project-20242025',
      storageBucket: 'mad-project-20242025.firebasestorage.app',
    );
  }

  static FirebaseOptions get ios {
    return FirebaseOptions(
      apiKey: dotenv.env['IOS_FIREBASE_API_KEY']!,
      appId: '1:500358298980:ios:851963f6c3cad1c3f28e71',
      messagingSenderId: '500358298980',
      projectId: 'mad-project-20242025',
      storageBucket: 'mad-project-20242025.firebasestorage.app',
      iosBundleId: 'com.example.deliveryApp',
    );
  }

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'FirebaseOptions are not supported for this platform.',
        );
    }
  }
}
