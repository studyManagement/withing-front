import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static late SharedPreferences _prefs;

  // 기본 생성자 막기
  SP._();

  static Future<void> of() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 가입 여부 저장
  static Future<bool> setJoinStatus(bool value) {
    return _prefs.setBool('is_join', value);
  }

  /// 가입 여부 획득
  static bool? getJoinStatus() {
    return _prefs.getBool('is_join');
  }
}
