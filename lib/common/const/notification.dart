import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false; // 셋팅여부 판단 flag

/// 세팅 메소드
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  //
  channel = const AndroidNotificationChannel(
    '채널 아이디', // id
    '채널 이름', // name
    description: '채널 설명',
    importance: Importance.high,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // iOS foreground notification 권한
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // IOS background 권한 체킹 , 요청
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // 토큰 요청
  await getToken();
  // 셋팅flag 설정
  isFlutterLocalNotificationsInitialized = true;
}

// Future<void> removeToken() async {
//   await FirebaseMessaging.instance.deleteToken().whenComplete(() {
//     if (kDebugMode) {
//       print('FCM token removed');
//     }
//   });
// }

Future<void> getToken() async {
  await FirebaseMessaging.instance.getToken().then((value) {
    if (kDebugMode) {
      print('FCM Token: $value');
    }
  });
}

/// fcm 배경 처리 - 백그라운드에 있을 경우
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await setupFlutterNotifications(); // 셋팅 메소드
  // showForegroundNotification(message);
}

/// fcm 전경 처리 - 로컬 알림 보이기
void showForegroundNotification(RemoteMessage message) {
  // 알림
  RemoteNotification? notification = message.notification;

  // 안드로이드 알림
  AndroidNotification? android = message.notification?.android;

  // 웹이 아니면서 안드로이드이고, 알림이 있는경우
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
          fullScreenIntent: true,
        ),
      ),
    );
  }
}
