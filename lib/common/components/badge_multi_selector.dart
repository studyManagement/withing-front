import 'package:flutter/material.dart';
import '../theme/app/app_colors.dart';

class BadgeMultiSelector extends StatefulWidget {
  final List<String> options;
  final int? maxSelectedOptions;

  const BadgeMultiSelector({
    super.key,
    required this.options,
    this.maxSelectedOptions,
  });

  @override
  State<BadgeMultiSelector> createState() => _BadgeMultiSelectorState();
}

class _BadgeMultiSelectorState extends State<BadgeMultiSelector> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: widget.options.map((option) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedOptions.contains(option)) {
                selectedOptions.remove(option);
              } else if (widget.maxSelectedOptions == null ||
                  selectedOptions.length < widget.maxSelectedOptions!) {
                selectedOptions.add(option);
              }
            });
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
          Text(text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected ? Colors.white : AppColors.gray500,
                  )),
        ],
      ),
    );
  }
}
