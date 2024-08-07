import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/service/signin/signin_service.dart';
import 'package:modi/view_models/signin/signin_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  _showErrorMessage(BuildContext context) async {
    String? errorMessage = Authentication.state.errorMessage;
    bool isLogOut = Authentication.state.isLogOut;

    await Future.delayed(const Duration(microseconds: 50));
    if (isLogOut && errorMessage != null && context.mounted) {
      // ModiModal.openDialog(
      //     context, '문제가 발생했어요', errorMessage, false, null, null);
      Authentication.state.resolveErrorStatus();
    }
    else if (errorMessage != null && context.mounted) {
      ModiModal.openDialog(
          context, '문제가 발생했어요', errorMessage, false, null, null);
      Authentication.state.resolveErrorStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    _showErrorMessage(context);
    return const DefaultLayout(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Title(),
              _Body(),
              _Bottom(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/login/logo.png',
              width: 187,
              height: 105,
            ),
            const Text(
              '쉽고 즐거운 스터디 생활',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.gray400,
                fontWeight: AppFonts.fontWeight500,
              ),
            ),
          ],
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Container());
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom();

  @override
  Widget build(BuildContext context) {
    final SigninViewModel vm = SigninViewModel(context, getIt<SigninService>());

    List<Widget> loginComponents = [
      CircleButton(
          image: Image.asset(
            'asset/kakao.png',
            width: 50,
            height: 50,
          ),
          onTap: () async {
            await vm.signin('kakao');
          }),
    ];

    if (!kIsWeb && Platform.isIOS) {
      loginComponents.addAll([
        const SizedBox(width: 16),
        CircleButton(
            image: Image.asset(
              'asset/apple.png',
              width: 50,
              height: 50,
            ),
            onTap: () async {
              await vm.signin('apple');
            }),
      ]);
    }

    return Expanded(
      flex: 0,
      child: Column(
        children: [
          const Text(
            'SNS 간편 로그인 하기',
            style: TextStyle(
              color: AppColors.gray800,
              fontSize: 14,
              fontWeight: AppFonts.fontWeight500,
            ),
          ),
          const SizedBox(height: 19),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: loginComponents,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 60)),
          // const Text(
          //   '로그인에 문제가 있어요',
          //   style: TextStyle(
          //     color: Color(0xffabb6c2),
          //     decoration: TextDecoration.underline,
          //     decorationColor: Color(0xffabb6c2),
          //     fontSize: 12,
          //   ),
          // )
        ],
      ),
    );
  }
}
