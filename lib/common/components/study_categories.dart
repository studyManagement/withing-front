import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:withing/common/theme/app/app_colors.dart';

class StudyCategories extends StatelessWidget {
  final List<String> categories;

  const StudyCategories({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var category in categories) {
      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: ShapeDecoration(
            color: AppColors.blue100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Text(
            category,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.blue500),
          ),
        ),
      );

      if (category != categories.last) {
        widgets.add(const SizedBox(width: 6));
      }
    }

    return Row(children: widgets);
  }
}
