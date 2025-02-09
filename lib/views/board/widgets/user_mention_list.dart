import 'package:flutter/material.dart';

import '../../../common/components/gray_container.dart';
import '../../../common/components/image/circle_image.dart';
import '../../../model/user/user_model.dart';

class UserMentionList extends StatelessWidget {
  final List<UserModel> users;
  final Function(UserModel user) onSelected;
  const UserMentionList({super.key, required this.users, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: users.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _UserMentionItem(
                imagePath: users[index].profileImage ?? '', nickname: users[index].nickname, onTap: () => onSelected(users[index])),
          ),
        ),
      ),
    );
  }
}

class _UserMentionItem extends StatelessWidget {
  final String imagePath;
  final String nickname;
  final Function() onTap;

  const _UserMentionItem(
      {super.key,
      required this.imagePath,
      required this.nickname,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          CircleImage(
              size: 30,
              image: Image.network(
                imagePath,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const GrayContainer(size: 38);
                },
              )),
          const SizedBox(width: 6),
          Text(nickname, style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
    );
  }
}
