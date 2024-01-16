import 'package:withing/service/signin/signin_service.dart';

class SigninViewModel {
  final SigninService _signinService;

  SigninViewModel(this._signinService);

  signin(String accessToken) async {
    await _signinService.signin(accessToken);
  }
}
