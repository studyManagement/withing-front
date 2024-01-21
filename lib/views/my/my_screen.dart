import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/authenticator/authentication.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/views/signup/signup_profile.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '마이페이지',
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Profile(),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(Authentication.instance.nickname,
                    style: TextStyle(fontSize: 16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[50],
                ),
                child: Center(
                  child: Text(
                    Authentication.instance.introduce,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              thickness: 5,
              height: 1,
              color: Colors.grey[200],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    onTap: () {
                      context.go('/my/studies');
                    },
                    leading: Image.asset(
                      'asset/like.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '찜한 스터디',
                      style: TextStyle(fontSize: 16),
                    ),
                    horizontalTitleGap: 16,
                  ),
                  ListTile(
                    onTap: () {
                      context.go('/my/studies');
                    },
                    leading: Image.asset(
                      'asset/finished.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '종료된 스터디',
                      style: TextStyle(fontSize: 16),
                    ),
                    horizontalTitleGap: 16,
                  ),
                  ListTile(
                    trailing:
                        const Text('v1.0.1', style: TextStyle(fontSize: 16)),
                    leading: Image.asset(
                      'asset/version.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '버전 정보',
                      style: TextStyle(fontSize: 16),
                    ),
                    horizontalTitleGap: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
