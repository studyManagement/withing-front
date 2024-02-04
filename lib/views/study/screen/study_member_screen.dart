import 'package:flutter/material.dart';
import 'package:modi/common/layout/default_layout.dart';

import '../../../common/theme/app/app_colors.dart';
import '../widgets/study_member_list_item.dart';

class StudyMemberScreen extends StatelessWidget {
  const StudyMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "참여 인원",
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
    );
  }
}
