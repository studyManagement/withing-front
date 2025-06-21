import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Color? selectedColor;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.blue400;
        }
        return AppColors.gray200;
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity:
          const VisualDensity(horizontal: VisualDensity.minimumDensity),
    );
  }
}

class CustomRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String title;

  const CustomRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRadioButton<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        const SizedBox(width: 10),
        Text(title, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
