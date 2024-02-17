import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/study_info_viewmodels.dart';

enum NewStudyType {
  studyName,
  studyDescription,
}

class StudyTextField extends StatefulWidget {
  final NewStudyType type;
  final StudyInfoViewModel viewModel;

  const StudyTextField({
    super.key,
    required this.type,
    required this.viewModel,
  });

  @override
  State<StudyTextField> createState() => _StudyTextFieldState();
}

class _StudyTextFieldState extends State<StudyTextField> {
  late TextEditingController controller;
  bool isInitiated = false;

  @override
  void didUpdateWidget(StudyTextField oldWidget) {
    if(!isInitiated && widget.viewModel.studyName.isNotEmpty) {
      super.didUpdateWidget(oldWidget);
      String initValue = (widget.type == NewStudyType.studyName)
          ? widget.viewModel.studyName
          : widget.viewModel.studyDescription;
      if (initValue != controller.text) {
        controller.text = initValue;
      }
      isInitiated = true;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    final bool isValidation = (widget.type == NewStudyType.studyName)
        ? widget.viewModel.isStudyNameError
        : widget.viewModel.isStudyDescriptionError;
    final int maxLength = (widget.type == NewStudyType.studyName) ? 20 : 65;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getStudyTitle(widget.type),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray500,
                ),
          ),
          TextField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) =>
                widget.viewModel.checkStudyNameAndDescription(widget.type, value),
            cursorHeight: 16,
            cursorWidth: 1.5,
            cursorColor: AppColors.blue500,
            decoration: InputDecoration(
              hintText: getHintText(widget.type),
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.gray200,
                  ),
              errorText: getErrorText(widget.type, isValidation),
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
