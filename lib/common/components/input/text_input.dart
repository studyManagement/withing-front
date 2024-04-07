import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      this._label, this._placeholder, this._maxLength, this._onChanged,
      {this.initialValue, super.key});

  final String _label;
  final String _placeholder;
  final String? initialValue;
  final int _maxLength;
  final Function(String) _onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _label,
          style: const TextStyle(
            color: AppColors.gray500,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            counterText: '',
            hintText: _placeholder,
            hintStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.gray200,
              fontWeight: FontWeight.w500,
            ),
          ),
          autofocus: true,
          maxLength: _maxLength,
          onChanged: _onChanged,
        ),
      ],
    );
  }
}
