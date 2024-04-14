import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class RadioItem<T> {
  RadioItem({required this.value, required this.title});

  final T value;
  final String title;
}

class RadioSelector<T> extends StatefulWidget {
  const RadioSelector({
    super.key,
    required this.items,
    required this.onChange,
  });

  final List<RadioItem> items;
  final Function(T) onChange;

  @override
  State<RadioSelector> createState() => _RadioSelectorState<T>();
}

class _RadioSelectorState<T> extends State<RadioSelector> {
  T? _value = null;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        RadioItem item = widget.items[index];

        return RadioListTile<T>(
          value: item.value,
          title: Text(
            item.title,
            style: const TextStyle(
              color: AppColors.gray800,
              fontSize: 14,
              fontWeight: AppFonts.fontWeight500,
            ),
          ),
          groupValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value as T;
            });
            widget.onChange(value!);
          },
          activeColor: AppColors.blue400,
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: AppColors.gray100),
        );
      },
      itemCount: widget.items.length,
    );
  }
}
