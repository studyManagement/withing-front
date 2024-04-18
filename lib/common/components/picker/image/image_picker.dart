import 'package:flutter/material.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/common/utils/pick_image_file.dart';
import '../../../theme/app/app_colors.dart';

enum UpdateType { STUDY, USER }

class ImagePicker extends StatelessWidget {
  final UpdateType type;

  const ImagePicker({
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text('대표 이미지', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 28),
          CircleImage(
            105,
            105,
            image: (type == UpdateType.USER)
                ? Image.network(
                    'https://static.moditeam.io/asset/default/representative/default.webp')
                : Image.network(
                    'https://static.moditeam.io/asset/default/representative/group_default.webp'),
          ),
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
                  icon: const Icon(Icons.camera_alt),
                ),
                CircleImage(
                  50,
                  50,
                  image:  (type == UpdateType.USER)
                      ? Image.network(
                      'https://static.moditeam.io/asset/default/representative/default.webp')
                      : Image.network(
                      'https://static.moditeam.io/asset/default/representative/group_default.webp'),
                ),
                CircleImage(
                  50,
                  50,
                  image: Image.network(
                      'https://static.moditeam.io/asset/default/representative/default2.webp'),
                ),
                CircleImage(
                  50,
                  50,
                  image: Image.network(
                      'https://static.moditeam.io/asset/default/representative/default3.webp'),
                ),
                CircleImage(
                  50,
                  50,
                  image: Image.network(
                      'https://static.moditeam.io/asset/default/representative/default4.webp'),
                ),
                CircleImage(
                  50,
                  50,
                  icon: const Icon(Icons.photo),
                ),
                CircleImage(
                  50,
                  50,
                  image: Image.network(
                      'https://static.moditeam.io/asset/default/representative/default5.webp'),
                ),
                CircleImage(
                  50,
                  50,
                  image: Image.network(
                      'https://static.moditeam.io/asset/default/representative/default6.webp'),
                ),
                CircleImage(
                  50,
                  50,
                  image: Image.network(
                      'https://static.moditeam.io/asset/default/representative/default7.webp'),
                ),
                CircleImage(
                  50,
                  50,
                  image: Image.network(
                      'https://static.moditeam.io/asset/default/representative/default8.webp'),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ConfirmButton(
                onTap: () => null,
                text: '취소',
                backgroundColor: AppColors.blue200,
              ),
              const SizedBox(width: 8),
              ConfirmButton(
                onTap: () => null,
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
