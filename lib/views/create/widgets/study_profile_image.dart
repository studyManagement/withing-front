import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/service/image/image_update_service.dart';
import 'package:modi/view_models/image/image_picker_viewmodel.dart';
import 'package:modi/view_models/study/study_info_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/components/image/profile.dart';
import '../../../common/components/picker/image/image_picker.dart';
import '../../../common/modal/modi_modal.dart';
import '../../../di/injection.dart';

class StudyProfileImage extends StatelessWidget {
  final StudyInfoViewModel viewModel;
  final bool isCreate;

  const StudyProfileImage({
    super.key,
    required this.viewModel,
    required this.isCreate,
  });

  ImageProvider getImageProvider() {
    AssetImage defaultImage = const AssetImage('asset/search_category/2_certification.png');
     if (isCreate) {
      if (viewModel.isDefault) {
        return AssetImage(viewModel.studyImagePath);
      } else if (viewModel.studyImageFile != null &&
          File(viewModel.studyImageFile!.path).existsSync()) {
        return FileImage(viewModel.studyImageFile!);
      }
    } else {
      if (viewModel.isOldImage) {
        return NetworkImage(viewModel.studyImagePath);
      } else if (viewModel.studyImageFile != null &&
          File(viewModel.studyImageFile!.path).existsSync()) {
        return FileImage(viewModel.studyImageFile!);
      }
    }
    // 기본 이미지
    return defaultImage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 50),
      child: ChangeNotifierProvider<ImagePickerViewModel>(
        create: (context) => ImagePickerViewModel(
          getIt<ImageUpdateService>(),
          getIt<ImageCreateService>(),
        ),
        child: Consumer<ImagePickerViewModel>(builder: (context, imgVm, _) {
          final shapeDecoration = ShapeDecoration(
            shape: const OvalBorder(),
            color: AppColors.blue100,
            image: DecorationImage(
              image: getImageProvider(),
              fit: BoxFit.cover,
            ),
          );
          return Profile(
            shapeDecoration: shapeDecoration,
            onTap: () {
              ModiModal.openBottomSheet(
                context,
                widget: ChangeNotifierProvider.value(
                  value: imgVm,
                  child: StudyImagePicker(
                        onSelected: () { // '확인' 눌러야 저장
                          viewModel.isDefault = imgVm.isDefault;
                          viewModel.isOldImage = false;
                          viewModel.studyImagePath = imgVm.imagePath;
                          viewModel.studyImageFile = imgVm.imageFile;
                          context.pop();
                        },
                      ),
                ),
                height: 496,
              );
            },
            bottomImagePath: 'asset/camera.png',
          );
        }),
      ),
    );
  }
}
