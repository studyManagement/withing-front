import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/authenticator/authentication_exception.dart';
import 'package:withing/common/authenticator/authentication_factory.dart';
import 'package:withing/common/authenticator/authenticator.dart';
import 'package:withing/common/modal/withing_modal.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/exception/signin/user_not_found_exception.dart';
import 'package:withing/service/signin/signin_service.dart';

class SigninViewModel {
  final BuildContext _context;
  final SigninService _signinService;

  SigninViewModel(this._context, this._signinService);

  signin(String provider) async {
    Authenticator auth = AuthenticationFactory.getProvider(provider);
    try {
      String token = await auth.login();
      await _signinService.signin(token);

      if (!_context.mounted) return;
      _context.go('/home');
    } on AuthenticationException catch (e) {
      WithingModal.openDialog(
          _context, '문제가 발생했어요', e.cause, false, null, null);
    } on UserNotFoundException catch (e) {
      int socialUUID = await auth.fetchUUID();
      if (!_context.mounted) return;
      _context.go('/signup/$provider/$socialUUID');
    } on ApiException catch (e) {
      WithingModal.openDialog(
          _context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }
}
