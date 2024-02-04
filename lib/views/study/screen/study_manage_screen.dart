import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/bottom_toast.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/withing_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/views/study/widgets/study_manage_bottomsheet.dart';
import 'package:provider/provider.dart';

import '../../../di/injection.dart';

class StudyManageScreen extends StatelessWidget {
  final int studyId;

  const StudyManageScreen({super.key, required this.studyId});

  @override
  Widget build(BuildContext context) {
    List<String> iconUrl = [
      'asset/study_manage/name=edit_38.png',
      'asset/study_manage/name=calender_38.png',
      'asset/study_manage/name=member_switch_38.png',
      'asset/study_manage/name=member_ban_38.png',
      'asset/study_manage/name=cancel_38.png',
    ];
    List<String> title = [
      '스터디 정보 수정',
      '정기 모임 설정',
      '스터디장 변경',
      '멤버 강제 퇴장',
      '스터디 종료'
    ];
    return ChangeNotifierProvider(
      create: (_) => StudyViewModel(getIt<StudyService>()),
      child: Consumer<StudyViewModel>(builder: (context, data, child) {
        return DefaultLayout(
            title: '스터디 관리',
            child: ListView(
              children: [
                for (int i = 0; i < 5; i++)
                  StudyManageListItem(
                      title: title[i],
                      iconUrl: iconUrl[i],
                      index: i,
                      studyId: studyId),
                const SizedBox(height: 369),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        WithingModal.openDialog(context, "스터디를 삭제하시겠어요?",
                            "스터디가 영구적으로 삭제되며,\n복구할 수 없어요.", true, () {
                          data.deleteStudy(studyId);
                          context.pop();
                          BottomToast(context: context, text: "스터디가 삭제되었어요.")
                              .show();
                          // context.go('/home');
                        }, null);
                      },
                      child: Text('스터디 삭제하기',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: AppColors.gray300,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.gray300))),
                )
              ],
            ));
      }),
    );
  }
}

class StudyManageListItem extends StatelessWidget {
  final String title;
  final String iconUrl;
  final int index;
  final int studyId;

  const StudyManageListItem(
      {super.key,
      required this.title,
      required this.iconUrl,
      required this.index,
      required this.studyId});

  @override
  Widget build(BuildContext context) {
    final StudyViewModel vm = context.read<StudyViewModel>();

    return GestureDetector(
        onTap: () {
          if (index == 0) {
            context.push('/studies/$studyId/manage/edit');
          } else if (index == 1) {
            context.push('/studies/$studyId/manage/regular_meeting');
          } else if (index == 2) {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  print("!");
                  return const StudyManageBottomSheet(
                    title: "스터디장 변경",
                    content: "스터디장을 위임받을 멤버를 선택해주세요.",
                    buttontext: "스터디장 위임하기",
                    isOut: false,
                  );
                });
          } else if (index == 3) {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const StudyManageBottomSheet(
                    title: "멤버 강제 퇴장",
                    content: "스터디에서 강제퇴장 할 멤버를 선택해주세요.",
                    buttontext: "강제 퇴장",
                    isOut: true,
                  );
                });
          } else if (index == 4) {
            WithingModal.openDialog(context, "스터디를 종료하시겠어요?",
                "더 이상 스터디를 진행할 수 없으며,\n종료된 스터디에 저장돼요.", true, () {
              vm.finishStudy(studyId);
              context.pop();
              BottomToast(context: context, text: "스터디가 종료되었어요.").show();
              // context.go('/home');
            }, null);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Image.asset(iconUrl, width: 38, height: 38),
              const Padding(padding: EdgeInsets.only(right: 6)),
              Text(title, style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ));
  }
}
