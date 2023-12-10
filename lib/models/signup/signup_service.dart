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
}
