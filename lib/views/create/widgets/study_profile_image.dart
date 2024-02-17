import 'package:flutter/material.dart';
import 'package:modi/view_models/study/study_info_viewmodels.dart';
import '../../../common/utils/pick_image_file.dart';
import '../../../common/theme/app/app_colors.dart';

class StudyProfileImage extends StatelessWidget {
  final StudyInfoViewModel viewModel;

  const StudyProfileImage({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // final viewModel2 = Provider.of<UpdateStudyViewModel>(context);
    ShapeDecoration? shapeDecoration;
    if (viewModel.studyImagePath.isNotEmpty ||
        viewModel.studyImageFile != null) {

      var image = (!viewModel.isOldImageLoaded)
          ? NetworkImage(viewModel.studyImagePath)
          : FileImage(viewModel.studyImageFile!);
      shapeDecoration = ShapeDecoration(
          shape: const OvalBorder(),
          image: DecorationImage(
            image: image as ImageProvider,
            fit: BoxFit.cover,
          ));
    } else {
      shapeDecoration =
          const ShapeDecoration(shape: OvalBorder(), color: AppColors.gray150);
    }
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
                viewModel.studyImageFile = await pickImageFile();
                viewModel.isOldImageLoaded = true;
              },
              child: Image.asset(
                'asset/camera.png',
                scale: 2,
              ),
            ),
          ),
        ));
  }
}
