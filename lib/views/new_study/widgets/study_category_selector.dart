import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/new_study/new_study_view_model.dart';

class StudyCategorySelector extends StatelessWidget {
  const StudyCategorySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewStudyViewModel>(context);
    final List<String> categories = getStudyCategories();
    final List<String> selectedCategories = viewModel.selectedCategories;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '카테고리 선택',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.gray500),
              ),
              const SizedBox(width: 8),
              Text(
                '최대 3개',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.gray300,
                      fontSize: 13.0,
                    ),
              )
            ],
          ),
          const SizedBox(height: 12),
          _BadgeMultiSelector(
            selectedOptions: selectedCategories,
            options: categories,
            maxCount: 3,
          ),
        ],
      ),
    );
  }
}

class _BadgeMultiSelector extends StatelessWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final int? maxCount;

  const _BadgeMultiSelector({
    required this.options,
    required this.selectedOptions,
    this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewStudyViewModel>(context);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        return GestureDetector(
          onTap: () {
            viewModel.updateSelectedCategories(option, maxCount);
          },
          child: _Badge(
            text: option,
            isSelected: selectedOptions.contains(option),
          ),
        );
      }).toList(),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _Badge({
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: ShapeDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : AppColors.gray100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isSelected ? Colors.white : AppColors.gray500,
                ),
          ),
        ],
      ),
    );
  }
}
