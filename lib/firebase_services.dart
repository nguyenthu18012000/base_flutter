import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class FirebaseServices {
  static Future initialize() async {
    await Firebase.initializeApp();
    await initializeFirebaseMessaging();
  }

  static Future initializeFirebaseMessaging({
    bool kIsWeb = false,
    String? channelId,
    String? channelName,
  }) async {
    if (!kIsWeb) {
      const initializationSettingsAndroid = AndroidInitializationSettings(
        'ic_launcher',
      );
      const initializationSettingsIOS = DarwinInitializationSettings();
      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin()
        ..initialize(
          initializationSettings,
        );

      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId ?? 'CHANNEL_ID',
        channelName ?? 'CHANNEL_NAME',
        importance: Importance.max,
        priority: Priority.max,
        autoCancel: false,
      );
      const iosNotificationDetails = DarwinNotificationDetails();
      final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosNotificationDetails,
      );

      FirebaseMessaging.instance.requestPermission();
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {

      });

      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {

        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final notification = message.notification;
        final android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          flutterLocalNotificationsPlugin.show(
            0,
            notification.title,
            notification.body,
            platformChannelSpecifics,
            payload: 'payload',
          );
        }
      });
    }
  }
}
