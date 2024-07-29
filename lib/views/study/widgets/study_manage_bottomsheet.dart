import 'package:flutter/material.dart';
import 'package:modi/common/components/study_bottom_button.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/views/study/widgets/study_member_list_item.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../common/components/bottom_toast.dart';
import '../../../model/user/user_model.dart';
import '../../../view_models/study/study_viewmodel.dart';

class StudyManageBottomSheet extends StatefulWidget {
  final int studyId;
  final String title;
  final String content;
  final String buttonText;
  final bool isOut;
  final List<UserModel> users;

  const StudyManageBottomSheet(
      {super.key,
      required this.studyId,
      required this.title,
      required this.content,
      required this.buttonText,
      required this.isOut,
      required this.users});

  @override
  State<StudyManageBottomSheet> createState() => _StudyManageBottomSheetState();
}

class _StudyManageBottomSheetState extends State<StudyManageBottomSheet> {

  @override
  Widget build(BuildContext context) {
    int maxCount = (widget.isOut) ? 14 : 1;
    final StudyViewModel vm = context.watch<StudyViewModel>();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.87,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero)),
      child: Column(children: [
        const SizedBox(height: 10),
        Container(
          width: 70,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.gray150,
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(widget.content,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.gray400)),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
          color: AppColors.gray100,
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: 522,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      final selectedUserId = widget.users[index].id;
                      vm.updateSelectedUsers(selectedUserId, maxCount);
                    },
                    child: StudyMemberListItem(
                      nickname: widget.users[index].nickname,
                      imageUrl: widget.users[index].profileImage,
                      id: widget.users[index].id,
                      isLeader: false,
                      isSelected:
                          vm.selectedUsers.contains(widget.users[index].id),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                    color: AppColors.gray100,
                  );
                },
                itemCount: widget.users.length),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: StudyBottomButton(
            color: (vm.selectedUsers.isNotEmpty) ? null : AppColors.gray200,
              onTap: () {
                if (vm.selectedUsers.isNotEmpty &&
                    vm.selectedUsers.length <= maxCount) {
                  if (widget.isOut) {
                    vm
                        .forceToExitMember(widget.studyId)
                        .then((_) => {
                              if (vm.isOut)
                                {
                                  context.pop(),
                                  BottomToast(
                                          context: context,
                                          text: "선택한 멤버를 퇴장시켰어요.")
                                      .show()
                                }
                            });
                  } else {
                    vm.switchLeader(widget.studyId).then((_) => {
                          if (vm.isSwitched)
                            {
                              context.pop(),
                              BottomToast(context: context, text: "스터디장이 변경되었어요.")
                                  .show(),
                            }
                        });
                  }
                }
              },
              text: widget.buttonText),
        )
      ]),
    );
  }
}
