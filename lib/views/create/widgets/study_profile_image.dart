import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/service/image/image_update_service.dart';
import 'package:modi/view_models/image/image_picker_viewmodel.dart';
import 'package:modi/view_models/study/study_info_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/components/image/profile.dart';
import '../../../common/components/picker/image/image_picker.dart';
import '../../../common/modal/modi_modal.dart';
import '../../../common/utils/pick_image_file.dart';
import '../../../di/injection.dart';

class StudyProfileImage extends StatelessWidget {
  final StudyInfoViewModel viewModel;
  final bool isCreate;

  const StudyProfileImage({
    super.key,
    required this.viewModel,
    required this.isCreate
  });

  @override
  Widget build(BuildContext context) {
    ShapeDecoration? shapeDecoration;
    if (viewModel.studyImagePath.isNotEmpty || viewModel.studyImageFile != null) { // 수정 시 파일 형식 이슈
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
      shapeDecoration = const ShapeDecoration(
          shape: OvalBorder(),
          image: DecorationImage(image: NetworkImage('https://static.moditeam.io/asset/default/representative/group_default.webp')));
    }
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 50),
        child: Profile(
          shapeDecoration: shapeDecoration,
          onTap: () {
            ModiModal.openBottomSheet(context, widget:
                ChangeNotifierProvider(
                create: (_) => ImagePickerViewModel(getIt<ImageUpdateService>(),
                    getIt<ImageCreateService>(), context),
                child: Consumer<ImagePickerViewModel>(
                    builder: (context, imgVm, _) {
                      if(imgVm.isSelected) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          viewModel.studyImageFile = imgVm.imageFile;
                          viewModel.studyImagePath = imgVm.imagePath;
                        });
                      }
                  return ImagePicker(
                    onSelected: (){
                      imgVm.isSelected = true;
                      isCreate ? imgVm.createImage() : imgVm.updateImage();
                      viewModel.isOldImageLoaded = true;
                      context.pop();
                    },
                    type: ObjectType.STUDY,
                  );
                })
          ), height: 496);
          },
          bottomImagePath: 'asset/camera.png',
          ),
        );
  }
}
