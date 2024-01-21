import 'package:flutter/material.dart';
import 'package:withing/common/authenticator/authenticator.dart';
import 'package:withing/common/authenticator/provider/kakao_authentication.dart';
import 'package:withing/common/components/circle_button.dart';
import 'package:withing/di/injection.dart';
import 'package:withing/service/signin/signin_service.dart';
import 'package:withing/view_models/signin/signin_viewmodel.dart';

import '../../common/authenticator/authenticator.dart';
import '../../common/authenticator/provider/kakao_authentication.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
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
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '스터디 관리도\n즐겁고 쉽게, 위딩',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: 300,
        height: 300,
        color: Colors.grey[200],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom();

  @override
  Widget build(BuildContext context) {
    final SigninViewModel vm = SigninViewModel(context, getIt<SigninService>());

    return Column(
      children: [
        const Text('SNS 간편 로그인 하기'),
        const SizedBox(height: 14),
        CircleButton(
            image: 'asset/kakao.png',
            onTap: () async {
              Authenticator auth = KakaoAuthentication();
              String token = await auth.login();
              int socialUUID = await auth.fetchUUID();
              
              await vm.signin(auth.getProvider(), socialUUID.toString(), token);
            }),
        const Padding(padding: EdgeInsets.only(bottom: 60)),
        const Text(
          '로그인에 문제가 있어요',
          style: TextStyle(
            color: Color(0xffabb6c2),
            decoration: TextDecoration.underline,
            decorationColor: Color(0xffabb6c2),
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
