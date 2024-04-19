import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/view_models/my/update_profile_viewmodel.dart';
import 'package:modi/views/signup/signup_profile.dart';
import 'package:provider/provider.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<UpdateProfileViewModel>();
    return DefaultLayout(
      title: '마이페이지',
      centerTitle: false,
      titleFontSize: 20,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                    onTap: () {
                      context.push('/my/profile');
                    },
                    child: Profile(
                      image: Image.network(viewModel.userImagePath),
                      bottomImagePath: 'asset/edit.png',
                    )),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(Authentication.instance.nickname,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.gray800,
                        fontWeight: AppFonts.fontWeight600)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.gray50,
                ),
                child: Center(
                  child: Text(
                    Authentication.instance.introduce,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.gray600,
                        fontWeight: AppFonts.fontWeight500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 5,
              height: 1,
              color: AppColors.gray50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    onTap: () {
                      context.push('/my/studies/like');
                    },
                    leading: Image.asset(
                      'asset/like.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '찜한 스터디',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray800,
                          fontWeight: AppFonts.fontWeight600),
                    ),
                    horizontalTitleGap: 16,
                  ),
                  ListTile(
                    onTap: () {
                      context.push('/my/studies/finished');
                    },
                    leading: Image.asset(
                      'asset/finished.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '종료된 스터디',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray800,
                          fontWeight: AppFonts.fontWeight600),
                    ),
                    horizontalTitleGap: 16,
                  ),
                  ListTile(
                    onTap: () {
                      return Authentication.instance
                          .logout(reason: '[디버그] 로그아웃 되었습니다.');
                    },
                    trailing: const Text('v1.0.0+31',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.gray400,
                            fontWeight: AppFonts.fontWeight500)),
                    leading: Image.asset(
                      'asset/version.png',
                      width: 40,
                      height: 40,
                    ),
                    title: const Text(
                      '버전 정보',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray800,
                          fontWeight: AppFonts.fontWeight600),
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
