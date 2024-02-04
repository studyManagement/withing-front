import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/view_models/search/searched_studies_viewmodel.dart';

import '../../../common/theme/app/app_fonts.dart';

class StudyListHeader extends StatelessWidget {
  final SearchedStudiesViewModel viewModel;

  const StudyListHeader({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    int studyCount = viewModel.studiesCount;

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
          _StudyFilterDropDownBox(
            viewModel: viewModel,
          )
        ],
      ),
    );
  }
}

class _StudyFilterDropDownBox extends StatelessWidget {
  final SearchedStudiesViewModel viewModel;

  const _StudyFilterDropDownBox({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    List<String> filters = getStudyFilters();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          DropdownButton(
              icon: Container(),
              underline: Container(),
              value: viewModel.filterValue,
              items: filters.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: buildDropdownItem(
                    context,
                    value,
                    viewModel.filterValue,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                viewModel.updateSearchFilterValue(value.toString());
                viewModel.search();
              }),
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
