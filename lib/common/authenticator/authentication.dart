import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Authentication {
  static late Authentication _instance;
  get getInstance => _instance;

  static Authentication get instance => _instance;

  Authentication._();

  String? _accessToken = null;
  String? _refreshToken = null;
  String _introduce = '';
  String _socialId = '';
  String _nickname = '';
  int _userId = -1;
  String _socialIdType = '';

  factory Authentication.from(String accessToken, String refreshToken) {
    Map<String, dynamic> decodeToken = JwtDecoder.decode(accessToken);

    Authentication authentication = Authentication._();
    authentication._accessToken = accessToken;
    authentication._refreshToken = refreshToken;
    authentication._userId = decodeToken['userId'];
    authentication._nickname = decodeToken['nickname'];
    authentication._introduce = decodeToken['introduce'];
    authentication._socialId = decodeToken['socialId'];
    authentication._socialIdType = decodeToken['socialIdType'];

    _instance = authentication;

    return _instance;
  }

  String get introduce => _introduce;
  String get socialId => _socialId;
  String get nickname => _nickname;
  int get userId => _userId;
  String get socialIdType => _socialIdType;
  String? get accessToken => _accessToken;
  String? get refreshToken => _accessToken;

  bool isExpired() {
    if (_accessToken == null) {
      return true;
    }

    return JwtDecoder.isExpired(_accessToken!);
  }

  void clearSession() {
    _accessToken = null;
    _refreshToken = null;
    _userId = -1;
    _nickname = '';
    _introduce = '';
    _socialId = '';
    _socialIdType = '';
  }

  void save() async {
    await const FlutterSecureStorage()
        .write(key: 'access_token', value: _accessToken);
    await const FlutterSecureStorage()
        .write(key: 'refresh_token', value: _refreshToken);
  }

  static Future<void> initialize() async {
    String? accessToken =
        await const FlutterSecureStorage().read(key: 'access_token');
    String? refreshToken =
        await const FlutterSecureStorage().read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      return;
    }

    Authentication.from(accessToken, refreshToken);
  }
}
