import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        print('Notification Clicked: ${details.payload}');
      },
    );

    // Create a default notification channel for Android 8.0+.
    const AndroidNotificationChannel defaultChannel = AndroidNotificationChannel(
      'default_channel',
      'Default Notifications',
      description: 'This channel is used for default notifications.',
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(defaultChannel);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String channelId = 'default_channel',
    String channelName = 'Default Notifications',
    String? channelDescription = 'This channel is used for notifications.',
    Importance importance = Importance.high,
    Priority priority = Priority.high,
    String? payload,
    bool showProgress = false,
    int? progress,
    int? maxProgress,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      showProgress: showProgress,
      maxProgress: maxProgress ?? 0,
      progress: progress ?? 0,
    );

    final details = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
