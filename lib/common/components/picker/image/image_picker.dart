import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/view_models/image/image_picker_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../theme/app/app_colors.dart';

enum ObjectType { STUDY, USER }

class StudyImagePicker extends StatelessWidget {
  final Function() onSelected;

  const StudyImagePicker({
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImagePickerViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text('스터디 대표 이미지', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 28),
          CircleImage(size: 105, image: viewModel.image),
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 20,
                  crossAxisCount: 4,
                ),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return CircleImage(
                      size: 50,
                      onTap: () => viewModel.takeOrPickPhoto(
                          ImageSource.camera, ObjectType.STUDY),
                      image: Image.asset('asset/camera_icon.png'),
                    );
                  }
                  if (index == 1) {
                    return CircleImage(
                      size: 50,
                      onTap: () => viewModel.takeOrPickPhoto(
                          ImageSource.gallery, ObjectType.STUDY),
                      image: Image.asset('asset/gallery_icon.png'),
                    );
                  } else {
                    return CircleImage(
                      size: 50,
                      onTap: () {
                        viewModel.setImageFile(
                            viewModel.representativeImagePaths[index - 1]);
                      },
                      image: Image.asset(
                          viewModel.representativeImagePaths[index - 1],
                          fit: BoxFit.cover),
                    );
                  }
                },
              ),
            ),
          ),
          Row(
            children: [
              ConfirmButton(
                onTap: () => context.pop(),
                text: '취소',
                backgroundColor: AppColors.blue200,
              ),
              const SizedBox(width: 8),
              ConfirmButton(
                onTap: () => onSelected(),
                text: '확인',
                backgroundColor: AppColors.blue600,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class UserImageBottomSheet extends StatelessWidget {
  final Function() onSelected;
  final Function() onDefault;
  final ImagePickerViewModel viewModel;

  const UserImageBottomSheet({super.key, required this.onSelected, required this.onDefault, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                await viewModel.takeOrPickPhoto(
                    ImageSource.gallery, ObjectType.USER);
                onSelected();
              },
              child: Text('앨범에서 가져오기',
                  style: Theme.of(context).textTheme.titleSmall)),
          const SizedBox(height: 18),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                await viewModel.takeOrPickPhoto(
                    ImageSource.camera, ObjectType.USER);
                onSelected();
              },
              child: Text('직접 촬영하기',
                  style: Theme.of(context).textTheme.titleSmall)),
          const SizedBox(height: 18),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                viewModel.setImageFile(viewModel.representativeImagePaths[0]);
                onDefault();
              },
              child: Text('기본 이미지로 변경',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.red400))),
        ],
      ),
    );
  }
}
