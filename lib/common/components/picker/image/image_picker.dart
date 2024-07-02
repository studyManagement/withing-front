import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/common/utils/pick_image_file.dart';
import 'package:modi/view_models/image/image_picker_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../theme/app/app_colors.dart';

enum ObjectType { STUDY, USER }

class ImagePicker extends StatelessWidget {
  final ObjectType type;
  final Function() onSelected;

  const ImagePicker({
    required this.type,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int topCount = 3, bottomCount = 7;
    final ImagePickerViewModel viewModel = context.read();

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
                      onTap: () =>
                          viewModel.takeOrPickPhoto(ImageSource.camera, type),
                      image: Image.asset('asset/camera_icon.png'),
                    );
                  }
                  if (index == 1) {
                    return CircleImage(
                      size: 50,
                      onTap: () =>
                          viewModel.takeOrPickPhoto(ImageSource.gallery, type),
                      image: Image.asset('asset/gallery_icon.png'),
                    );
                  } else {
                    return CircleImage(
                      size: 50,
                      onTap: () {
                        viewModel.setImageFile(
                            viewModel.representativeImagesUrl[index-1]);
                      },
                      image: Image.asset(
                          viewModel.representativeImagesUrl[index-1],
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
                onTap: onSelected,
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
