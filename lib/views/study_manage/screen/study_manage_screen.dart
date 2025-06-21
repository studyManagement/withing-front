import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/views/study_manage/screen/set_regular_meeting_screen.dart';
import 'package:modi/views/study_manage/widgets/study_manage_bottomsheet.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../../../model/user/user_model.dart';

class StudyManageItem {
  final String icon;
  final String title;
  final void Function(BuildContext context, StudyViewModel vm) onTap;

  StudyManageItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class StudyManageScreen extends StatelessWidget {
  final StudyViewModel viewModel;
  const StudyManageScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final List<UserModel> users = List.from(viewModel.users)
      ..removeWhere((user) => user.id == viewModel.study!.leaderId);

    final studyId = viewModel.study!.id;

    List<StudyManageItem> studyMenu = [
      StudyManageItem(
        icon: 'asset/study_manage/edit_38.png',
        title: '스터디 정보 수정',
        onTap: (context, vm) => context.push('/studies/$studyId/manage/edit'),
      ),
      StudyManageItem(
        icon: 'asset/study_manage/calender_38.png',
        title: '정기 모임 설정',
        onTap: (context, vm) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SetRegularMeetingScreen(viewModel: vm),
          ),
        ),
      ),
      StudyManageItem(
        icon: 'asset/study_manage/member_add_38.png',
        title: '스터디 가입 신청',
        onTap: (context, vm) {
          context.push('/studies/$studyId/manage/add');
        },
      ),
      StudyManageItem(
        icon: 'asset/study_manage/member_switch_38.png',
        title: '스터디장 변경',
        onTap: (context, vm) {
          showManageBottomSheet(
            context,
            studyId,
            "스터디장 변경",
            "스터디장을 위임받을 멤버를 선택해주세요.",
            "스터디장 위임하기",
            users,
            isOut: false,
          );
        },
      ),
      StudyManageItem(
        icon: 'asset/study_manage/member_ban_38.png',
        title: '멤버 강제 퇴장',
        onTap: (context, vm) {
          showManageBottomSheet(
            context,
            studyId,
            "멤버 강제 퇴장",
            "스터디에서 강제퇴장 할 멤버를 선택해주세요.",
            "${vm.selectedUsers.length}명 퇴장",
            users,
            isOut: true,
          );
        },
      ),
      StudyManageItem(
        icon: 'asset/study_manage/cancel_38.png',
        title: '스터디 종료',
        onTap: (context, vm) {
          ModiModal.openDialog(
            context,
            "스터디를 종료하시겠어요?",
            "더 이상 스터디를 진행할 수 없으며,\n종료된 스터디에 저장돼요.",
            true,
                () => vm.finishStudy(context),
            null,
          );
        },
      ),
    ];

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: DefaultLayout(
        title: '스터디 관리',
        child: ListView(
          children: [
            ...studyMenu.map((item) => StudyManageListItem(item: item, studyViewModel: viewModel)),
            const SizedBox(height: 340),
            Center(
              child: GestureDetector(
                  onTap: () {
                    ModiModal.openDialog(context, "스터디를 삭제하시겠어요?",
                        "스터디가 영구적으로 삭제되며,\n복구할 수 없어요.", true, () {
                          viewModel.deleteStudy(context);
                        }, null);
                  },
                  child: Text('스터디 삭제하기',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.gray300,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.gray300))),
            )
          ],
        ),
      ),
    );
  }

  void showManageBottomSheet(
      BuildContext context,
      int studyId,
      String title,
      String content,
      String buttonText,
      List<UserModel> users, {
        required bool isOut,
      }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => StudyViewModel(getIt<StudyService>()),
          child: Consumer<StudyViewModel>(
            builder: (context, provider, child) {
              return StudyManageBottomSheet(
                studyId: studyId,
                title: title,
                content: content,
                buttonText: buttonText,
                isOut: isOut,
                users: users,
              );
            },
          ),
        );
      },
    );
  }
}

class StudyManageListItem extends StatelessWidget {
  final StudyManageItem item;
  final StudyViewModel studyViewModel;

  const StudyManageListItem({
    super.key,
    required this.item,
    required this.studyViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item.onTap(context, studyViewModel),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Image.asset(item.icon, width: 38, height: 38),
            const SizedBox(width: 6),
            Text(item.title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}



