import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/firebase_options.dart';

import '../const/notification.dart';

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService._setupFlutterNotifications();
  await NotificationService._showNotification(message);
}

class NotificationService {
  LoggingInterface logger = getIt<LoggingInterface>();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  Future<void> _foregroundHandler(RemoteMessage message) async {
    _showNotification(message);
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null && !kIsWeb) {
      NotificationService._notification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> _setupFlutterNotifications() async {
    channel = const AndroidNotificationChannel('channel', 'channel name',
        importance: Importance.high);

    await NotificationService._notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> initialize() async {
    await _requestPermission();

    logger.info(await FirebaseMessaging.instance.getToken());

    FirebaseMessaging.onMessage.listen(_foregroundHandler);
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    if (!kIsWeb) {
      await _setupFlutterNotifications();
    }
  }
}
