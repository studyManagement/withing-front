import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/environment/environment.dart';
import 'package:modi/common/logger/app_event.dart';
import 'package:modi/common/logger/logger_service.dart';
import 'package:modi/common/notification/notification_service.dart';
import 'package:modi/constants/auth.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/firebase_options.dart';
import 'package:modi/withing_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LoggerService.instance.appEvent(AppEvent.APP_OPEN, method: "main.main()");

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await initializeDateFormatting();

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

  await Environment.initialize(BuildType.LOCAL);
  await Authentication.initialize();

  setupDependencyInjection();

  if (!kIsWeb) {
    await NotificationService.instance.initialize();
  }

  runApp(const WithingApp());
}
