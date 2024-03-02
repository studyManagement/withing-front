import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:modi/common/router/router_service.dart';
import 'package:modi/common/theme/withing_theme.dart';

class WithingApp extends StatelessWidget {
  const WithingApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    RouterService.instance.initializeRoute();

    return MaterialApp.router(
      theme: WithingTheme.withingThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: RouterService.instance.router,
    );
  }
}
