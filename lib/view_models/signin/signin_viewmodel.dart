import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication_exception.dart';
import 'package:modi/common/authenticator/authentication_factory.dart';
import 'package:modi/common/authenticator/authenticator.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/exception/signin/user_not_found_exception.dart';
import 'package:modi/model/device/device_model.dart';
import 'package:modi/service/signin/signin_service.dart';
import 'package:modi/service/update/update_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/logger/logging_interface.dart';
import '../../di/injection.dart';

class SigninViewModel {
  final SigninService _signinService;

  SigninViewModel(this._signinService);

  signin(BuildContext context, String provider) async {
    Authenticator auth = AuthenticationFactory.getProvider(provider);
    try {
      String token = await auth.login();
      await _signinService.signin(token, provider);
      final isRequiredUpdate = await checkUpdateAndRegisterDevice();
      if (isRequiredUpdate) {
        Uri uri = Uri.parse("https://apps.apple.com/kr/app/modi-%EB%AA%A8%EB%94%94/id6505111586");
        if (!context.mounted) return;
        ModiModal.openDialog(
          context,
          '업데이트가 필요해요',
          '최신 버전 업데이트를 위해 스토어로 이동합니다.',
          false,
              () => launchUrl(uri) ,// onOk
          null,
        );
       return;
      }
      
      if (!context.mounted) return;
      context.go('/');
    } on AuthenticationException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    } on UserNotFoundException catch (e) {
      String socialUUID = await auth.fetchUUID();
      if (!context.mounted) return;
      context.push('/signup/$provider/$socialUUID');
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }

  Future<bool> checkUpdateAndRegisterDevice() async {
    String? fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint('FCM 토큰 가져오기 실패: $e'); // 시뮬레이터에서는 토큰 없음
    }

    final deviceId = await _getDeviceId();
    final osVersion = await _getOsVersion();
    final appVersion = await _getAppVersion();
    final deviceInfo = DeviceModel(
      id: deviceId,
      token: fcmToken ?? '',
      osVersion: osVersion,
      appVersion: appVersion,
    );

    try {
      final isUpdateRequired = await getIt<UpdateService>().checkForUpdate(
          deviceInfo);
      return isUpdateRequired;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown_ios';
    }
    return 'unknown_platform';
  }

  Future<String> _getOsVersion() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.systemVersion;
    }
    return 'unknown';
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}

