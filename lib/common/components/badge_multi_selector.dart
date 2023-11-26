import 'package:flutter/material.dart';

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
        color: isSelected ? const Color(0xFF1F3258) : const Color(0xFFF4F7FC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF6E7986),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
