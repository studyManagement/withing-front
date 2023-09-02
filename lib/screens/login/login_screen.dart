import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:withing/common/secure_storage.dart';

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
    return Column(
      children: [
        const Text('SNS 간편 로그인'),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            // 경우 1. 로그인을 해서 키를 가지고 있다면 바로 홈화면으로
            // 경우 2. 회원가입이 안되어 있으면 회원가입 페이지로
            await kakaoLogin(context);
            // print(await KakaoSdk.origin);
          },
          child: Image.asset(
            'asset/kakao.png',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }

  Future<void> kakaoLogin(BuildContext context) async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        final accessToken = token.accessToken;
        SecureStorage.setAccessToken(accessToken);
        final test = await SecureStorage.getAccessToken();
        print('secure에서 키값 뽑기  : $test');
        _getUserInfo();
        if (context.mounted) {
          context.go('/home');
        }
      } catch (error) {
        print('카카오톡 로그인 실패 $error');
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,W
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          print('11111111');
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오 계정 로그인 성공');
        } catch (error) {
          print('카카오 계정 로그인 실패1111 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오 계정 로그인 성공');
      } catch (error) {
        print('카카오 계정 로그인 실패22222 $error');
      }
    }
  }

  void _getUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      final tf = user.hasSignedUp = false;
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n가입여부: $tf');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }
}
