import 'package:flutter/widgets.dart';
import 'package:modi/common/components/checkbox/checkbox_state.dart';

class IconCheckBox<T> extends StatefulWidget {
  const IconCheckBox({
    super.key,
    required this.notCheckedColor,
    required this.checkedColor,
    required this.checkedBackgroundColor,
    required this.notCheckedBackgroundColor,
    required this.icon,
    required this.size,
    required this.value,
    required this.onChange,
  });

  final Color notCheckedColor;
  final Color checkedColor;
  final Color checkedBackgroundColor;
  final Color notCheckedBackgroundColor;
  final double size;
  final IconData icon;
  final T value;
  final ValueChanged<CheckBoxState<T>> onChange;

  @override
  State<IconCheckBox<T>> createState() => _IconCheckBoxState<T>();
}

class _IconCheckBoxState<T> extends State<IconCheckBox<T>> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onChange(
          CheckBoxState<T>(
            isChecked: _isChecked,
            value: widget.value,
          ),
        );
      },
      child: Container(
        color: _isChecked
            ? widget.checkedBackgroundColor
            : widget.notCheckedBackgroundColor,
        child: Icon(
          widget.icon,
          size: widget.size,
          color: _isChecked ? widget.checkedColor : widget.notCheckedColor,
        ),
      ),
    );
  }
}
