import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:modi/common/logger/app_event.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/router/router_service.dart';
import 'package:modi/common/theme/withing_theme.dart';
import 'package:modi/di/injection.dart';

class WithingApp extends StatelessWidget {
  const WithingApp({super.key});

  @override
  Widget build(BuildContext context) {
    LoggingInterface logger = getIt<LoggingInterface>();

    FlutterNativeSplash.remove();

    logger.appEvent(AppEvent.APP_OPEN, method: "main.main()");

    return MaterialApp.router(
      theme: WithingTheme.withingThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: RouterService.instance.router,
    );
  }
}
