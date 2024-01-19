import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/new_study/new_study_view_model.dart';

enum NewStudyType {
  studyName,
  studyDescription,
}

class StudyTextField extends StatelessWidget {
  final NewStudyType type;

  const StudyTextField({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewStudyViewModel>(context);
    final bool isValidation = (type == NewStudyType.studyName)
        ? viewModel.isStudyNameError
        : viewModel.isStudyDescriptionError;
    final int maxLength = (type == NewStudyType.studyName) ? 20 : 65;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getStudyTitle(type),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray500,
                ),
          ),
          TextField(
            onChanged: (value) =>
                viewModel.checkStudyNameAndDescription(type, value),
            cursorHeight: 16,
            cursorWidth: 1.5,
            cursorColor: AppColors.blue500,
            decoration: InputDecoration(
              hintText: getHintText(type),
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.gray200,
                  ),
              errorText: getErrorText(type, isValidation),
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
                borderSide: BorderSide(color: AppColors.gray150),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray150),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray150),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray150),
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
