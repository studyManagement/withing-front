import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/utils/pick_image_file.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/create/create_study_viewmodel.dart';

class StudyProfileImage extends StatelessWidget {
  const StudyProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateStudyViewModel>(context);
    ShapeDecoration shapeDecoration = viewModel.studyImage != null
        ? ShapeDecoration(
            shape: const OvalBorder(),
            image: DecorationImage(
              image: FileImage(viewModel.studyImage!),
              fit: BoxFit.cover,
            ),
          )
        : const ShapeDecoration(
            shape: OvalBorder(),
            color: AppColors.gray150,
          );

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 50),
      child: Center(
        child: Container(
          width: 105,
          height: 105,
          decoration: shapeDecoration,
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () async {
              debugPrint('프로필 사진 선택');
              viewModel.studyImage = await pickImageFile();
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
