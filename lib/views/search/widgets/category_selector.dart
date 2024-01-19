import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_models/search/search_viewmodel.dart';

class CategorySelector extends StatelessWidget {
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

  CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<SearchViewModel>(context);

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
              viewModel.selectedCategoryValue = index;
              debugPrint(categories[index]);
            },
            child: CategoryItem(
              title: categories[index],
              isSelected: viewModel.selectedCategoryValue == index,
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.title,
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
              border: Border.all(
                width: 2.0,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}
