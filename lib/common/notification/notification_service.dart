import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/router/router_service.dart';
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
  static final NotificationService _notificationService =
      NotificationService._privateConstructor();
  static NotificationService get instance => _notificationService;
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  NotificationService._privateConstructor();

  Future<void> _foregroundHandler(RemoteMessage message) async {
    String? routePath = _getRoutePath(message);
    _showNotification(message, payload: routePath);
  }

  static Future<void> _showNotification(RemoteMessage message,
      {String? payload}) async {
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
        payload: payload ?? "",
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
    InitializationSettings initSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );

    _notification.initialize(initSettings,
        onDidReceiveNotificationResponse:
            instance._onForegroundMessageOpenHandler);

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
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenHandler);

    if (!kIsWeb) {
      await _setupFlutterNotifications();
    }
  }

  void setOnMessageOpenedAppListener(Function(RemoteMessage) callback) {
    FirebaseMessaging.onMessageOpenedApp.listen(callback);
  }

  void _onMessageOpenHandler(RemoteMessage message) {
    String? routePath = _getRoutePath(message);

    if (routePath == null) {
      return;
    }

    _onClickPush(routePath);
  }

  void _onForegroundMessageOpenHandler(
      NotificationResponse notificationResponse) {
    String? payload = notificationResponse.payload;

    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        if (payload == null) {
          return;
        }

        _onClickPush(payload);

        break;
      case NotificationResponseType.selectedNotificationAction:
        break;
    }
  }

  String? _getRoutePath(RemoteMessage message) {
    if (!message.data.containsKey("modi-routing")) {
      return null;
    }

    return message.data['modi-routing'] as String;
  }

  void _onClickPush(String routePath, {Map<String, dynamic>? parameters}) {
    RouterService.instance.router.push(routePath);
  }
}
