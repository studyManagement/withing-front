import 'dart:convert';

class SignupModel {
  late String _provider;
  late String _accessToken;
  late String _nickname;
  late String _introduce;

  set provider(String value) {
    _provider = value;
  }

  set accessToken(String value) {
    _accessToken = value;
  }

  set nickname(String value) {
    _nickname = value;
  }

  set introduce(String value) {
    _introduce = value;
  }

  String toJson() {
    return jsonEncode({
      "social_id_type": _provider,
      "social_id": _accessToken,
      "nickname": _nickname,
      "introduce": _introduce,
    });
  }
}
