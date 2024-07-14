import 'package:flutter/material.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:provider/provider.dart';

import '../../../common/components/study_categories_widget.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/study_viewmodel.dart';

class Header extends StatelessWidget {
  // 이미지, 스터디 이름, 스터디 카테고리

  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    Container grayContainer =
        Container(width: 64, height: 64, color: AppColors.gray150);

    final StudyViewModel vm = context.read<StudyViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleImage(
              size: 64,
              image: (vm.study!.studyImage == null)
                  ? null
                  : Image.network(
                      vm.study!.studyImage!,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return grayContainer;
                      },
                    )),
          const SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vm.study!.studyName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if(vm.study!.categories.every((e) => e.isNotEmpty))
              StudyCategoriesWidget(categories: vm.study!.categories),
            ],
          ),
        ],
      ),
    );
  }
}
