import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

class StudyProfileImage extends StatelessWidget {
  const StudyProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 50),
      child: Center(
        child: Container(
          width: 105,
          height: 105,
          decoration: const ShapeDecoration(
            color: AppColors.gray150,
            shape: OvalBorder(),
          ),
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              debugPrint('프로필 사진 선택');
            },
            child: Image.asset(
              'asset/camera.png',
              scale: 2,
            ),
          ),
        ),
      ),
    );
  }
}
