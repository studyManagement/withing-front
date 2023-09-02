import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class SecureStorage {
  // 기본 생성자 막기
  SecureStorage._();

  /// 액세스 토큰 저장
  static Future<void> setAccessToken(String value) async {
    await storage.write(key: 'access_token', value: value);
  }

  /// 액세스 토큰 획득
  static Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }
}
