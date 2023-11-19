import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:withing/constants/auth.dart';

import 'common/const/notification.dart';
import 'common/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();

  // setting 함수
  await setupFlutterNotifications();
  // 백그라운드 메시지 수신
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // 포그라운드 메시지 수신 : 안드로이드는 '높은 우선순위' 알림 채널을 만들어야한다.
  FirebaseMessaging.onMessage.listen(showForegroundNotification);

  // 가로, 세로 모드 허용
  await SystemChrome.setPreferredOrientations([
    // 세로 상향 고정
    DeviceOrientation.portraitUp,
    // 세로 하향 고정
    DeviceOrientation.portraitDown,
    // 왼쪽으로 가로 회전
    DeviceOrientation.landscapeLeft,
    // 오른쪽으로 가로 회전
    DeviceOrientation.landscapeRight,
  ]);

  KakaoSdk.init(
    nativeAppKey: KAKAO_NATIVE_KEY,
    javaScriptAppKey: KAKAO_JAVSCRIPT_KEY,
  );

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    ),
  );
}
