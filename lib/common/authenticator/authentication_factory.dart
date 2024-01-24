import 'package:withing/common/authenticator/authenticator.dart';
import 'package:withing/common/authenticator/provider/empty_authentication.dart';
import 'package:withing/common/authenticator/provider/kakao_authentication.dart';

class AuthenticationFactory {
  static Authenticator getProvider(String provider) {
    switch (provider) {
      case 'kakao':
        return KakaoAuthentication();

      default:
        return EmptyAuthentication();
    }
  }
}
