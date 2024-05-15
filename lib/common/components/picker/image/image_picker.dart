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
    int topCount = 5, bottomCount = 9;
    final ImagePickerViewModel viewModel = context.read();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text('대표 이미지', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 28),
          CircleImage(105, 105, image: viewModel.image),
          const SizedBox(height: 40),
          Expanded(
            child: GridView(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 5,
              ),
              children: [
                CircleImage(
                  50,
                  50,
                  onTap: () => viewModel.takeOrPickPhoto(ImageSource.camera, type),
                  icon: const Icon(Icons.camera_alt),
                ),
                CircleImage(
                  50,
                  50,
                  onTap: () {
                    viewModel.setImageFile((type == ObjectType.USER)
                        ? viewModel.representativeImagesUrl[0]
                        : viewModel.representativeImagesUrl[1]);
                  },
                  image: viewModel.defaultImage,
                ),
                for (int i = 2; i < topCount; i++)
                  CircleImage(
                    50,
                    50,
                    onTap: () {
                      viewModel
                          .setImageFile(viewModel.representativeImagesUrl[i]);
                    },
                    image: Image.network(viewModel.representativeImagesUrl[i], fit: BoxFit.cover),
                  ),
                CircleImage(
                  50,
                  50,
                  onTap: () => viewModel.takeOrPickPhoto(ImageSource.gallery,type),
                  icon: const Icon(Icons.photo),
                ),
                for (int i = topCount; i < bottomCount; i++)
                  CircleImage(
                    50,
                    50,
                    onTap: () {
                      viewModel
                          .setImageFile(viewModel.representativeImagesUrl[i]);
                    },
                    image: Image.network(viewModel.representativeImagesUrl[i], fit: BoxFit.cover,),
                  ),
              ],
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
