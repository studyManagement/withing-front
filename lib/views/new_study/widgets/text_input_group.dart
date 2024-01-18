import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

enum NewStudyType {
  studyName,
  studyDescription,
}

class TextInputGroup extends StatelessWidget {
  final NewStudyType type;
  final String title;
  final String hintText;
  final String errorText;
  final int? maxLength;
  final bool isValidation;
  final void Function(String) validationCheck;

  const TextInputGroup({
    super.key,
    required this.type,
    required this.title,
    required this.hintText,
    required this.errorText,
    this.maxLength = 20,
    required this.isValidation,
    required this.validationCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray500,
                ),
          ),
          TextField(
            onChanged: validationCheck,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.gray200,
                  ),
              errorText: getErrorMessage(type, isValidation),
              errorStyle: isValidation
                  ? Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.blue400,
                      )
                  : Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.gray400,
                      ),
              counterStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.gray500,
                  ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E8F0)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E8F0)),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E8F0)),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E8F0)),
              ),
            ),
            maxLength: maxLength,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

String getErrorMessage(NewStudyType type, bool isValidation) {
  if (type == NewStudyType.studyName) {
    return isValidation ? '멋진 이름이네요!' : '2 ~ 20자 사이의 이름을 설정해주세요.';
  } else if (type == NewStudyType.studyDescription) {
    return isValidation ? '멋진 설명이네요!' : '10 ~ 65자 사이의 이름을 설정해주세요.';
  } else {
    return '유효하지 않은 입력입니다.';
  }
}
