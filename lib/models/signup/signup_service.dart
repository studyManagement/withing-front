import 'package:flutter/cupertino.dart';
import 'package:withing/common/requester/api_response.dart';
import 'package:withing/common/requester/requester.dart';
import 'package:withing/models/signup/signup_model.dart';

class SignupService extends ChangeNotifier {
  late SignupModel _signupModel;

  SignupService() {
    _signupModel = SignupModel();
  }

  Future<bool> isDuplicate(nickname) async {
    final queryParameters = {
      'nickname': nickname,
    };

    ApiResponse response = await Requester.get('/users/check', queryParameters);

    if (response.code == 409) {
      return true;
    }

    return false;
  }

  Future<bool> signup() async {
    ApiResponse apiResponse =
        Requester.post('/users/signup', _signupModel.toJson());

    _signupModel.accessToken = 'test1234';

    if (apiResponse.code == 400) {
      return false;
    }

    return true;
  }

  setProvider(String provider) {
    _signupModel.provider = provider;
  }

  setAccessToken(String accessToken) {
    _signupModel.accessToken = accessToken;
  }

  setNickname(String nickname) {
    _signupModel.nickname = nickname;
  }

  setIntroduce(String introduce) {
    _signupModel.introduce = introduce;
  }
}
