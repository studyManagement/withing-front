import 'package:flutter/material.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/image/circle_image.dart';

import '../../../theme/app/app_colors.dart';
import '../../../theme/app/app_fonts.dart';

class ImagePicker extends StatelessWidget {
  const ImagePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '대표 이미지',
          style: TextStyle(
            color: AppColors.gray900,
            fontWeight: AppFonts.fontWeight600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        CircleImage(
          105,
          105,
          image: Image.network(
              'https://static.moditeam.io/asset/default/representative/default.png'),
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
                image: Image.network(
                    'https://static.moditeam.io/asset/default/representative/default1.webp'),
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
    );
  }
}
