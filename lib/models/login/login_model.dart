enum LoginType { KAKAO, APPLE }

class Login {
  final String _accessToken;
  final String _refreshToken;

  Login(this._accessToken, this._refreshToken);

  String get refreshToken => _refreshToken;
  String get accessToken => _accessToken;
}
