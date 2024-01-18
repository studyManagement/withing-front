import 'package:flutter/material.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/views/study/widgets/study_manage_bottomsheet.dart';
import 'package:withing/views/study/widgets/study_manage_modal.dart';

class StudyManageScreen extends StatelessWidget {
  const StudyManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '스터디 관리',
        child: ListView(
          children: [
            const StudyManageListItem(
              title: '스터디 정보 수정',
              iconUrl: 'asset/study_manage/name=edit_38.png',
              index: 0,
            ),
            const StudyManageListItem(
              title: '정기 모임 설정',
              iconUrl: 'asset/study_manage/name=calender_38.png',
              index: 1,
            ),
            const StudyManageListItem(
              title: '스터디장 변경',
              iconUrl: 'asset/study_manage/name=member_switch_38.png',
              index: 2,
            ),
            const StudyManageListItem(
              title: '멤버 강제 퇴장',
              iconUrl: 'asset/study_manage/name=member_ban_38.png',
              index: 3,
            ),
            const StudyManageListItem(
              title: '스터디 종료',
              iconUrl: 'asset/study_manage/name=cancel_38.png',
              index: 4,
            ),
            const SizedBox(height: 369),
            Center(
              child: GestureDetector(
                  onTap: () {
                    showStudyDeleteDialog(context);
                  },
                  child: Text('스터디 삭제하기',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.gray300,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.gray300))),
            )
          ],
        ));
  }
}

class StudyManageListItem extends StatelessWidget {
  final String title;
  final String iconUrl;
  final int index;

  const StudyManageListItem(
      {super.key,
      required this.title,
      required this.iconUrl,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if(index == 4) showStudyFinishDialog(context);
          if(index == 2){
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder:(context){
              return const StudyManageBottomSheet(
                title: "스터디장 변경",
                content: "스터디장을 위임받을 멤버를 선택해주세요.",
                buttontext: "스터디장 위임하기",
                isMultiple: false,
              );
                }
            );
          }
          if(index == 3){
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder:(context){
                  return const StudyManageBottomSheet(
                    title: "멤버 강제 퇴장",
                    content: "스터디에서 강제퇴장 할 멤버를 선택해주세요.",
                    buttontext: "강제 퇴장",
                    isMultiple: true,
                  );
                }
            );
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
