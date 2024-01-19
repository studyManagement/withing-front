import 'package:flutter/material.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/common/components/study_bottom_button.dart';
import 'package:withing/views/study/widgets/study_member_list_item.dart';

class StudyManageBottomSheet extends StatelessWidget {
  final String title;
  final String content;
  final String buttontext;
  final bool isMultiple;

  const StudyManageBottomSheet(
      {super.key,
      required this.title,
      required this.content,
      required this.buttontext,
      required this.isMultiple});

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height:10),
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
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(content,
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
                  return StudyMemberListItem(
                    nickname: "nickname",
                    image: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.gray150,
                      ),
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
                itemCount: 10),
          ),
        ),
        const SizedBox(height: 12),
        StudyManageButton(onTap: () {}, text: buttontext)
      ]),
    );
  }
}
