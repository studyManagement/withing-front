import 'package:flutter/material.dart';
import 'package:modi/common/layout/responsive_size.dart';
import 'package:modi/view_models/search/searched_studies_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/search/category_search_viewmodel.dart';

class SearchCategorySelector extends StatelessWidget {
  const SearchCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTabletPrt = (screenWidth >= tabletPortrait) ? true : false;
    var viewModel = Provider.of<CategorySearchViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            mainAxisExtent: (isTabletPrt) ? screenWidth * 0.12: null),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              viewModel.searchCategory = index;
              viewModel.search();
            },
            child: _CategoryItem(
              title: categories[index],
              imgUrl: categoryImages[index],
              isSelected: viewModel.selectedValue == index,
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
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? AppColors.blue100 : Colors.transparent,
          ),
          child: Image.asset(
            imgUrl,
            scale: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(title),
      ],
    );
  }
}
