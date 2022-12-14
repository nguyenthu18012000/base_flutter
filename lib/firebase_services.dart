import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class FirebaseServices {
  static Future initialize(bool kIsWeb) async {
    await Firebase.initializeApp();
    await initializeFirebaseMessaging(kIsWeb: kIsWeb);
    await initializeDynamicLinks();
  }

  static Future initializeFirebaseMessaging({
    bool kIsWeb = false,
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

      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'CHANNEL_ID',
        'CHANNEL_NAME',
        importance: Importance.max,
        priority: Priority.max,
        autoCancel: false,
      );
      const iosNotificationDetails = DarwinNotificationDetails();
      const platformChannelSpecifics = NotificationDetails(
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
          .listen((RemoteMessage message) async {});

      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {}
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

  static Future initializeDynamicLinks() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
    }).onError((error) {

    });
  }

  static FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
}
