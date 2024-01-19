import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/search_study/search_study_viewmodel.dart';

class SearchCategorySelector extends StatelessWidget {
  final List<String> categories = [
    '전체',
    '어학',
    '자격증',
    '취업',
    '시험',
    '취미',
    '프로그래밍',
    '기타'
  ];
  final List<String> categoryImages = [
    'asset/search_category/0_entire.png',
    'asset/search_category/1_language.png',
    'asset/search_category/2_certification.png',
    'asset/search_category/3_employment.png',
    'asset/search_category/4_exam.png',
    'asset/search_category/5_hobby.png',
    'asset/search_category/6_programming.png',
    'asset/search_category/7_etc.png',
  ];

  SearchCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<SearchStudyViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              viewModel.searchCategory = index;
              debugPrint(categories[index]);
            },
            child: _CategoryItem(
              title: categories[index],
              imgUrl: categoryImages[index],
              isSelected: viewModel.selectedCategoryValue == index,
            ),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String title;
  final String imgUrl;
  final bool isSelected;

  const _CategoryItem({
    required this.title,
    required this.imgUrl,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.blue100 : Colors.transparent,
            ),
            child: Image.asset(
              imgUrl,
              scale: 2,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}
