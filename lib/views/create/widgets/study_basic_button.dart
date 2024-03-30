import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/create_study_viewmodel.dart';

class StudyBasicButton extends StatelessWidget {
  const StudyBasicButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateStudyViewModel>(context);
    final bool isEverythingFilled = viewModel.checkEverythingFilled();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: isEverythingFilled
              ? Theme.of(context).colorScheme.primary
              : AppColors.gray200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => {
          if (isEverythingFilled) {viewModel.createStudy()}
        },
        child: Text(
          '생성하기',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
    );
  }
}
