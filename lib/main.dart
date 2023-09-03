import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'common/router.dart';
import 'common/sp.dart';
import 'info/kakao_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: kakaoAppKey);

  // 인스턴스 생성
  await SP.of();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await initializeDateFormatting();

  // 가로, 세로 모드 허용
  await SystemChrome.setPreferredOrientations(
    [
      // 세로 상향 고정
      DeviceOrientation.portraitUp,
      // 세로 하향 고정
      DeviceOrientation.portraitDown,
      // 왼쪽으로 가로 회전
      DeviceOrientation.landscapeLeft,
      // 오른쪽으로 가로 회전
      DeviceOrientation.landscapeRight,
    ],
  );

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    ),
  );
}
