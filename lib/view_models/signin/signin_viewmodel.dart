import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/exception/signin/user_not_found_exception.dart';
import 'package:withing/service/signin/signin_service.dart';

class SigninViewModel {
  final BuildContext _context;
  final SigninService _signinService;

  SigninViewModel(this._context, this._signinService);

  signin(String provider, String socialUUID, String accessToken) async {
    try {
      await _signinService.signin(accessToken);

      log('dd');
      if (!_context.mounted) return;
      _context.go('/home');
    } on UserNotFoundException catch (e) {
      _context.go('/signup/$provider/$socialUUID');
    } on ApiException catch (e) {
      log('[LOG] ${e.code} ${e.cause}');
    }
  }
}
