import 'package:flutter/material.dart';
import 'package:modi/views/study/widgets/study_member_list_item.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../model/user/user_model.dart';

class StudyMemberList extends StatelessWidget {
  final List<UserModel> users;
  final int leaderId;

  const StudyMemberList({super.key, required this.users, required this.leaderId});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return StudyMemberListItem(
            nickname: users[index].nickname,
            imageUrl: users[index].profileImage,
            id: users[index].id,
            isSelected: false,
            isLeader: users[index].id == leaderId,
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
        itemCount: users.length);
  }
}

