import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';

class QuestionTextField extends StatelessWidget {
  final String hintText;
  final int maxLength;
  final bool isValidate;
  final Function(String)? onChanged;

  const QuestionTextField(
      {super.key,
        required this.hintText,
        required this.maxLength,
        required this.isValidate,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: (value) => onChanged,
      cursorHeight: 16,
      cursorWidth: 1.5,
      cursorColor: AppColors.blue500,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.gray300,
        ),
        counterStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.gray400,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
      ),
      maxLength: maxLength,
    );
  }
}