import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/theme_resources.dart';
import '../../../view_models/search/search_viewmodel.dart';

class FilterDropDownBox extends StatelessWidget {
  final List<String> valueList;

  const FilterDropDownBox({
    Key? key,
    required this.valueList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          Consumer<SearchViewModel>(
            builder: (context, viewModel, _) {
              return DropdownButton(
                icon: Container(),
                underline: Container(),
                value: viewModel.selectedFilterValue,
                items: valueList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: buildDropdownItem(
                      context,
                      value,
                      viewModel.selectedFilterValue,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  viewModel.selectedFilterValue = value;
                },
              );
            },
          ),
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
