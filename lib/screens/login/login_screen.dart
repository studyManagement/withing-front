import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:withing/common/api.dart';

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
            await kakaoLogin(context);
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
}

/// 카카오 로그인
Future<void> kakaoLogin(BuildContext context) async {
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
    } catch (error) {
      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        if (context.mounted) {
          Navigator.pop(context);
        }
        return;
      }
      // 카카오톡에 연결된 카카오 계정이 없는 경우, 카카오 계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
  // 카카오톡이 설치 되어 있지 않은 경우
  else {
    try {
      await UserApi.instance.loginWithKakaoAccount();

      User user = await UserApi.instance.me();

      int userId = user.id;

      final resp = await Api.getUserInfo(userId: userId);

      bool isMember = resp?.data['success'] ?? false;

      // 회원이면
      if (isMember) {
        context.go('/home');
      } else {
        // TODO userId 전달
        context.go('/signup/$userId');
      }
    } catch (error) {
      print('카카오 계정으로 로그인 실패 $error');
    }
  }
}
