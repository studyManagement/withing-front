import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/add_member_viewmodel.dart';
import '../../study_manage/widgets/question_text_field.dart';

class _QnaFormItem extends StatelessWidget {
  final List<Question> questions;
  final void Function(int index, String val) onChanged;

  const _QnaFormItem({
    super.key,
    required this.questions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final question = questions[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('질문 ${index + 1}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue500)),
                  const SizedBox(width: 6),
                  Text(question.content, style: TextTheme.of(context).bodySmall)
                ],
              ),
              const SizedBox(height: 20),
              QuestionTextField(
                maxLength: 20,
                hintText: question.example,
                isValidate: true,
                onChanged: (val) => onChanged(index, val),
              ),
            ],
          ),
        );
      },
    );
  }
}