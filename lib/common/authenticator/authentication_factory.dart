import 'package:modi/common/authenticator/authenticator.dart';
import 'package:modi/common/authenticator/provider/apple_authentication.dart';
import 'package:modi/common/authenticator/provider/empty_authentication.dart';
import 'package:modi/common/authenticator/provider/kakao_authentication.dart';

class AuthenticationFactory {
  static Authenticator getProvider(String provider) {
    switch (provider) {
      case 'kakao':
        return KakaoAuthentication();

      case 'apple':
        return AppleAuthentication();

      default:
        return EmptyAuthentication();
    }
  }
}
