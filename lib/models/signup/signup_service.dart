import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:withing/common/const/environment.dart';
import 'package:withing/common/environment/environment.dart';
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

    final uri = Uri.http(
        Environment.getEnv(API_SERVER), '/users/check', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 409) {
      return true;
    }

    return false;
  }

  signup() async {
    final uri = Uri.http(Environment.getEnv(API_SERVER), '/users/signup');
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: _signupModel.toJson());

    log(_signupModel.toJson());

    if (response.statusCode != 201) {
      return;
    }
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
