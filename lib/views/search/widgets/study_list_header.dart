import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import '../../../common/theme/app/app_fonts.dart';
import '../../../view_models/search_study/search_study_viewmodel.dart';

class StudyListHeader extends StatelessWidget {
  final SearchType type;

  const StudyListHeader({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchStudyViewModel>(context);
    int studyCount = (type == SearchType.category)
        ? viewModel.studyCountWithCategory
        : viewModel.studyCountWithKeyword;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '스터디',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.gray400),
              ),
              const SizedBox(width: 6),
              Text(
                '$studyCount',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.gray600),
              )
            ],
          ),
          _StudyFilterDropDownBox(type: type)
        ],
      ),
    );
  }
}

class _StudyFilterDropDownBox extends StatelessWidget {
  final SearchType type;

  const _StudyFilterDropDownBox({required this.type});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchStudyViewModel>(context);
    List<String> filters = getStudyFilters();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          DropdownButton(
              icon: Container(),
              underline: Container(),
              value: (type == SearchType.category)
                  ? viewModel.categoryFilterValue
                  : viewModel.keywordFilterValue,
              items: filters.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: buildDropdownItem(
                    context,
                    value,
                    (type == SearchType.category)
                        ? viewModel.categoryFilterValue
                        : viewModel.keywordFilterValue,
                  ),
                );
              }).toList(),
              onChanged: (value) =>
                  viewModel.updateSearchFilterValue(type, value!)),
        ],
      ),
    );
  }

  Widget buildDropdownItem(
      BuildContext context, String value, String? selectedValue) {
    return (value == selectedValue)
        ? Row(children: [
            Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: AppFonts.fontSize13,
                    color: AppColors.gray600,
                  ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 16.0,
              color: AppColors.gray400,
            )
          ])
        : Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: AppFonts.fontSize13,
                  color: AppColors.gray600,
                ),
          );
  }
}
