import 'package:flutter/material.dart';
import 'package:withing/common/requester/request_builder.dart';
import 'package:withing/model/signup/signup_exception.dart';
import 'package:withing/service/signup/signup_service.dart';

class SignupViewModel extends ChangeNotifier {
  SignupService service =
      SignupService(SignupApi(RequestBuilder.getInstance()));

  String message = '2-10자, 띄어쓰기 및 특수문자 불가';
  int rgb = 0xFF8B97A4;

  SignupViewModel(String provider, String accessToken);

  //SignupViewModel(String provider, String accessToken) {
  //  service.setProvider(provider);
  //  service.setAccessToken(accessToken);
  //}

  _checkViolationWords(String nickname) {
    final matchPattern = RegExp(r'(\s|[^a-zA-Zㄱ-힣0-9])');
    return matchPattern.hasMatch(nickname);
  }

  changeNickname(String nickname) async {
    try {
      if (nickname.length < 2) {
        throw SignupException('닉네임은 2-10글자여야해요.');
      }

      if (_checkViolationWords(nickname)) {
        throw SignupException('특수문자, 띄어쓰기는 사용 불가능해요.');
      }

      bool isDuplicate = await service.isDuplicate(nickname);
      if (isDuplicate) {
        throw SignupException('이미 사용중인 닉네임이에요.');
      }

      message = '사용 가능한 닉네임이에요.';
      rgb = 0xFF4282FF;
    } on SignupException catch (error) {
      message = error.cause;
      rgb = 0xFFFF416A;
    } finally {
      notifyListeners();
    }
  }

  changeDescription(String introduce) {}

  signup(BuildContext context) async {
    //bool isOk = await service.signup();

    //if (!isOk) {
    //  return;
    //}

    //if (!context.mounted) return;
    //context.go('/home');
  }
}
