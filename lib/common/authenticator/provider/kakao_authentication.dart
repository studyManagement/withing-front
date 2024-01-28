import 'dart:developer';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:withing/common/authenticator/authentication_exception.dart';
import 'package:withing/common/authenticator/authenticator.dart';

class KakaoAuthentication implements Authenticator {
  @override
  Future<String> login() async {
    bool isInstalled = await isKakaoTalkInstalled();

    log('kakao hash : ${await KakaoSdk.origin}');

    try {
      OAuthToken token = (isInstalled)
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      log('Kakao OAuth : ${token.toJson().toString()}');

      return token.accessToken;
    } on KakaoAuthException catch (e) {
      throw AuthenticationException(
          '[${await KakaoSdk.origin}] ${e.errorDescription.toString()}');
    }
  }

  @override
  Future<int> fetchUUID() async {
    User user = await UserApi.instance.me();
    return user.id;
  }

  @override
  String getProvider() {
    return "kakao";
  }
}
