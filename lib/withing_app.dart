import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/logger/logger_service.dart';
import 'package:modi/common/router/router_service.dart';
import 'package:modi/common/theme/withing_theme.dart';
import 'package:uni_links/uni_links.dart';

class WithingApp extends StatelessWidget {
  const WithingApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    // URI Scheme DeepLink
    uriLinkStream.listen((Uri? uri) {
      LoggerService.instance.info("uri: $uri");
      RouterService.instance.router.go(uri?.path ?? '/');
    }, onError: (Object err) {
      LoggerService.instance.error("err: $err");
    });

    return MaterialApp.router(
        theme: WithingTheme.withingThemeData,
        debugShowCheckedModeBanner: false,
        routerConfig: RouterService.instance.router);
  }
}
