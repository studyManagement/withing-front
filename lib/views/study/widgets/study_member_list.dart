import 'package:flutter/material.dart';
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
          return _StudyMemberListItem(
            nickname: users[index].nickname,
            imageUrl: users[index].profileImage,
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

class _StudyMemberListItem extends StatelessWidget {
  final String nickname;
  final String? imageUrl;
  final bool isLeader;

  const _StudyMemberListItem({
    required this.nickname,
    required this.imageUrl,
    required this.isLeader,
  });

  @override
  Widget build(BuildContext context) {
    Container grayContainer =
    Container(width: 38, height: 38, color: AppColors.gray150);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          ClipOval(
            child:  (imageUrl != null)
                ? Image.network(
              imageUrl!,
              width: 38,
              height: 38,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return grayContainer;
              },
            )
                : grayContainer,
          ),
          const SizedBox(width: 12),
          Text(
            nickname,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(width: 12),
          Offstage(
              offstage: (isLeader == true) ? false : true,
              child: Image.asset(
                'asset/leader_20.png',
                width: 20,
                height: 20,
              ))
        ],
      ),
    );
  }
}
