import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/model/study/study_info_model.dart';
import '../../../common/components/study_categories_widget.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/study_viewmodel.dart';

class Header extends StatelessWidget { // 이미지, 스터디 이름, 스터디 카테고리

  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    StudyInfoViewModel vm = Provider.of<StudyInfoViewModel>(context);


    List<String> categories =[];


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Container(
                decoration: const BoxDecoration( // image 추가 필요
                  shape: BoxShape.circle,
                  color: AppColors.gray150,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 vm.studyInfo!.studyName,
                  //'네이버 면접 스터디',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                StudyCategoriesWidget(categories: categories),
              ],
            ),
          ],
        ),

    );
  }
}

