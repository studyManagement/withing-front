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

  const StudyProfileImage(
      {super.key, required this.viewModel, required this.isCreate});

  @override
  Widget build(BuildContext context) {
    ShapeDecoration? shapeDecoration;
      var image = (viewModel.isOldImage)
              ? NetworkImage(viewModel.studyImagePath)
              : FileImage(viewModel.studyImageFile!);
      shapeDecoration = ShapeDecoration(
          shape: const OvalBorder(),
          color: AppColors.blue100,
          image: DecorationImage(
            image: image as ImageProvider,
            fit: BoxFit.cover,
          ));
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 50),
      child: Profile(
        shapeDecoration: shapeDecoration,
        onTap: () {
          ModiModal.openBottomSheet(context,
              widget: ChangeNotifierProvider(
                  create: (_) => ImagePickerViewModel(
                      getIt<ImageUpdateService>(),
                      getIt<ImageCreateService>(),
                      context),
                  child: Consumer<ImagePickerViewModel>(
                      builder: (context, imgVm, _) {
                    if (imgVm.isSelected) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        viewModel.studyImageFile = imgVm.imageFile;
                        viewModel.studyImagePath = imgVm.imagePath;
                      });
                    }
                    return ImagePicker(
                      onSelected: () {
                        imgVm.createImage().then((value) =>
                            viewModel.studyImageUuid = imgVm.imageUuid);
                        viewModel.isOldImage = false;
                        context.pop();
                      },
                      type: ObjectType.STUDY,
                    );
                  })),
              height: 496);
        },
        bottomImagePath: 'asset/camera.png',
      ),
    );
  }
}
