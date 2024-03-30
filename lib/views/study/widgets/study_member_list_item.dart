import 'package:flutter/material.dart';
import 'package:modi/common/components/image/circle_image.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../model/user/user_model.dart';

class StudyMemberListItem extends StatelessWidget {
  final String nickname;
  final String? imageUrl;
  final int id;
  final bool isSelected;
  final bool isLeader;

  StudyMemberListItem({
    required this.nickname,
    required this.imageUrl,
    required this.id,
    required this.isSelected,
    required this.isLeader,
  });

  @override
  Widget build(BuildContext context) {
    Container grayContainer = Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.gray150,
        shape: BoxShape.circle,
        border: Border.all(
          color: (isSelected) ? AppColors.blue600 : Colors.transparent,
          // 테두리 색상
          width: 1, // 테두리 두께
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: (isSelected)
                      ? AppColors.blue600
                      : Colors.transparent, // 테두리 색상
                  width: 1, // 테두리 두께
                ),
              ),
              child: CircleImage(38, 38,
                  image: (imageUrl != null)
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
                      : null)),
          const SizedBox(width: 12),
          Text(
            nickname,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: (isSelected) ? AppColors.blue500 : AppColors.black),
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
