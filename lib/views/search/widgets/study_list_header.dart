import 'package:flutter/material.dart';
import 'package:withing/common/theme/app/app_colors.dart';

import 'search_widget_resources.dart';

class StudyListHeader extends StatelessWidget {
  const StudyListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '스터디',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.gray400,
                    ),
              ),
              const SizedBox(width: 6),
              Text(
                '9,999',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.gray600,
                    ),
              )
            ],
          ),
          const FilterDropDownBox(
            valueList: ['최신순', '인기순', '등록순'],
          )
        ],
      ),
    );
  }
}
