import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthState extends ChangeNotifier {
  bool _isAuthentication = false;
  String? _errorMessage;

  void _updateAuthStatus(bool isAuthentication) {
    _isAuthentication = isAuthentication;
    notifyListeners();
  }

  void _updateErrorStatus(String? reason) {
    _errorMessage = reason;
  }

  void resolveErrorStatus() {
    _errorMessage = null;
    notifyListeners();
  }

  bool get isAuthentication => _isAuthentication;
  String? get errorMessage => _errorMessage;
}

class Authentication {
  static Authentication _instance = Authentication._();
  static final AuthState _state = AuthState();

  static Authentication get instance => _instance;
  static AuthState get state => _state;

  Authentication._();

  String? _accessToken;
  String? _refreshToken;
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
    _state._updateAuthStatus(true);

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

  void logout({String? reason}) async {
    _accessToken = null;
    _refreshToken = null;
    _userId = -1;
    _nickname = '';
    _introduce = '';
    _socialId = '';
    _socialIdType = '';

    _state._updateErrorStatus(reason);
    _state._updateAuthStatus(false);

    await const FlutterSecureStorage().delete(key: 'access_token');
    await const FlutterSecureStorage().delete(key: 'refresh_token');
  }

  void save() async {
    await const FlutterSecureStorage()
        .write(key: 'access_token', value: _accessToken);
    await const FlutterSecureStorage()
        .write(key: 'refresh_token', value: _refreshToken);
    FirebaseAnalytics.instance.logLogin(loginMethod: "Authentication.save()");
  }

  static Future<bool> initialize() async {
    String? accessToken =
        await const FlutterSecureStorage().read(key: 'access_token');
    String? refreshToken =
        await const FlutterSecureStorage().read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      return false;
    }

    Authentication.from(accessToken, refreshToken);

    return true;
  }
}
