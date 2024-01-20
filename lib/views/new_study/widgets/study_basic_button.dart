import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/new_study/new_study_view_model.dart';

class StudyBasicButton extends StatelessWidget {
  const StudyBasicButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewStudyViewModel>(context);
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
          if (isEverythingFilled) {debugPrint('스터디 생성하기')}
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
