import 'package:modi/common/authenticator/authentication_exception.dart';
import 'package:modi/common/authenticator/authenticator.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthentication implements Authenticator {
  String? _userIdentifier;

  @override
  Future<String> fetchUUID() async {
    if (_userIdentifier == null) {
      throw AuthenticationException('애플 아이디 정보를 불러올 수 없어요.');
    }
    return _userIdentifier!;
  }

  @override
  String getProvider() {
    return 'apple';
  }

  @override
  Future<String> login() async {
    final credentials = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);

    _userIdentifier = credentials.userIdentifier;

    return credentials.authorizationCode;
  }
}
