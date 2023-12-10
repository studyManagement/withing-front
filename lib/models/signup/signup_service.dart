import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:withing/common/const/environment.dart';
import 'package:withing/common/environment/environment.dart';
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
    final uri = Uri.http(Environment.getEnv(API_SERVER), '/users/signup');
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: _signupModel.toJson());

    _signupModel.accessToken = 'test1234';

    log(_signupModel.toJson());
    log('response code: ${response.statusCode}');
    log('response body: ${response.body}');

    if (response.statusCode == 400) {
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
