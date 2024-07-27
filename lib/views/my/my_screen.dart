import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/circular_indicator.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/service/user/user_service.dart';
import 'package:modi/view_models/my/update_profile_viewmodel.dart';
import 'package:modi/common/components/image/profile.dart';
import 'package:provider/provider.dart';

import '../../di/injection.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UpdateProfileViewModel>();
    viewModel.fetchUserProfileImage();
    viewModel.getAppVersion();

    return DefaultLayout(
      title: '마이페이지',
      centerTitle: false,
      titleFontSize: 20,
      child: (viewModel.isLoading)
          ? const CircularIndicator()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Profile(
                            onTap: () => context.push('/my/profile', extra: viewModel),
                            shapeDecoration: ShapeDecoration(
                                shape: const OvalBorder(),
                                image: DecorationImage(
                                    image: _buildProfileImage(
                                        viewModel.userImagePath),
                                    fit: BoxFit.cover)),
                            bottomImagePath: 'asset/edit.png',
                          )),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(viewModel.nickname,
                            style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.gray800,
                                fontWeight: AppFonts.fontWeight600)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.gray50,
                        ),
                        child: Center(
                          child: Text(
                            viewModel.introduce,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ListTile(
                            onTap: () {
                              context.push('/my/studies/like',
                                  extra: viewModel);
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
                              context.push('/my/studies/finished',
                                  extra: viewModel);
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
                          const SizedBox(height: 20),
                          const Divider(
                            thickness: 5,
                            height: 1,
                            color: AppColors.gray50,
                          ),
                          ListTile(
                            onTap: () {
                              // return Authentication.instance
                              //     .logout(reason: '[디버그] 로그아웃 되었습니다.');
                            },
                            trailing: Text(viewModel.appVersion,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.blue400,
                                    fontWeight: AppFonts.fontWeight500)),
                            // leading: Image.asset(
                            //   'asset/version.png',
                            //   width: 40,전
                            //   height: 40,
                            // ),
                            title: const Text(
                              '버전 정보',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray800,
                                  fontWeight: AppFonts.fontWeight600),
                            ),
                            horizontalTitleGap: 16,
                          ),
                          ListTile(
                            onTap: () {
                              return Authentication.instance.logout(
                                  reason: '로그아웃 되었습니다.', isLogOut: true);
                            },
                            title: const Text(
                              '로그아웃',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray800,
                                  fontWeight: AppFonts.fontWeight600),
                            ),
                            horizontalTitleGap: 16,
                          ),
                          ListTile(
                            onTap: () {
                              ModiModal.openDialog(
                                  context,
                                  '모디를 탈퇴하시겠어요?',
                                  '스터디 및 일정을 포함한 모든 회원 정보가\n삭제되며, 복구할 수 없어요.',
                                  true,
                                  () => context.pop(),
                                  () => getIt<UserService>().withdraw(context),
                                  leftText: '취소',
                                  leftColor: AppColors.blue200,
                                  rightText: '탈퇴하기',
                                  rightColor: AppColors.red400);
                            },
                            title: const Text(
                              '회원탈퇴',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray300,
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
            ),
    );
  }

  ImageProvider _buildProfileImage(String path) {
    if (path.isEmpty) {
      return const AssetImage('asset/user_default_image.png');
    }
    return NetworkImage(path);
  }
}
