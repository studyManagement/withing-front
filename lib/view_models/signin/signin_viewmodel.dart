import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication_exception.dart';
import 'package:modi/common/authenticator/authentication_factory.dart';
import 'package:modi/common/authenticator/authenticator.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/exception/signin/user_not_found_exception.dart';
import 'package:modi/service/signin/signin_service.dart';

class SigninViewModel {
  final SigninService _signinService;

  SigninViewModel(this._signinService);

  signin(BuildContext context, String provider) async {
    Authenticator auth = AuthenticationFactory.getProvider(provider);
    try {
      String token = await auth.login();
      await _signinService.signin(token, provider);

      if (!context.mounted) return;
      context.go('/');
    } on AuthenticationException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    } on UserNotFoundException catch (e) {
      String socialUUID = await auth.fetchUUID();
      if (!context.mounted) return;
      context.push('/signup/$provider/$socialUUID');
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }
}
