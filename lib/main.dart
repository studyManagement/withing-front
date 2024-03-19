import 'dart:async';

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
import 'package:modi/common/router/router_service.dart';
import 'package:modi/constants/auth.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/firebase_options.dart';
import 'package:modi/withing_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const String sentryDsn =
    'https://1f4f92d5383cd9332c6e636bdeab4674@o4506934796943360.ingest.us.sentry.io/4506934797991936';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LoggerService.instance.appEvent(AppEvent.APP_OPEN, method: "main.main()");

  setupDependencyInjection();

  await Environment.initialize(BuildType.LOCAL);
  await Authentication.initialize();

  await RouterService.instance.initializeRoute();

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

  if (!kIsWeb) {
    await NotificationService.instance.initialize();
  }

  if (!kDebugMode) {
    runZonedGuarded(() async {
      await SentryFlutter.init(
        (options) {
          options.dsn = sentryDsn;
          // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
          // We recommend adjusting this value in production.
          options.tracesSampleRate = 1.0;
        },
        appRunner: () => runApp(const WithingApp()),
      );
    }, (exception, stackTrace) async {
      Sentry.captureException(exception, stackTrace: stackTrace);
    });
  } else {
    runApp(const WithingApp());
  }
}
