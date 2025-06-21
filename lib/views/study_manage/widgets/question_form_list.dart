import 'package:flutter/material.dart';
import 'package:modi/common/components/bottom_toast.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/view_models/study/add_member_viewmodel.dart';
import 'package:modi/views/study_manage/widgets/question_text_field.dart';
import 'package:provider/provider.dart';

class QuestionFormList extends StatelessWidget {
  const QuestionFormList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddMemberViewModel>();
    final buttonColor = (viewModel.questions.length < 5)
        ? AppColors.blue400
        : AppColors.gray200;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ...List.generate(
            viewModel.questions.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: _QuestionExampleFormItem(
                index: index,
                question: viewModel.questions[index],
                onDelete: () => viewModel.deleteQuestion(index),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: (viewModel.questions.length < 5)
                  ? viewModel.addQuestion
                  : BottomToast(context: context, text: '질문은 최대 5개까지 추가 가능해요', backgroundColor: AppColors.blue600)
                      .show,
              icon: Icon(Icons.add, color: buttonColor),
              label: Text(
                '질문 추가하기',
                style: TextTheme.of(context)
                    .bodyMedium
                    ?.copyWith(color: buttonColor),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: buttonColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionExampleFormItem extends StatelessWidget {
  final int index;
  final Question question;
  final Function() onDelete;

  const _QuestionExampleFormItem({
    super.key,
    required this.index,
    required this.question,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('질문 ${index + 1}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.blue500)),
              const SizedBox(height: 12),
              QuestionTextField(
                maxLength: 20,
                onChanged: (val) => question.content = val,
                hintText: '질문을 작성해 주세요.',
                isValidate: true,
              ),
              const SizedBox(height: 4),
              QuestionTextField(
                maxLength: 20,
                onChanged: (val) => question.content = val,
                hintText: '예시 답변을 작성해 주세요',
                isValidate: true,
              ),
            ],
          ),
        ),
        Positioned(
            right: 4,
            child: IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.close, color: AppColors.gray300)))
      ],
    );
  }
}
