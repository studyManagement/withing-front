import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/new_study/new_study_view_model.dart';

class StudyMemberCount extends StatelessWidget {
  const StudyMemberCount({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewStudyViewModel>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '스터디 인원',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.gray500),
              ),
              const SizedBox(width: 8),
              Text(
                '최대 15명',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.gray300,
                      fontSize: 13.0,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 54,
                height: 22,
                child: TextField(
                  onChanged: (value) {
                    if (value != '') {
                      viewModel.memberCount = int.parse(value);
                    } else {
                      viewModel.memberCount = 0;
                    }
                  },
                  decoration: const InputDecoration(
                    counterText: '',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray150),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray150),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray150),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray150),
                    ),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    ZeroToFifteenInputFormatter(),
                  ],
                  cursorHeight: 16,
                  cursorWidth: 1.5,
                  cursorColor: AppColors.blue500,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                ),
              ),
              Transform.translate(
                offset: const Offset(-16, 0),
                child: Text(
                  '명',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColors.gray500),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// input format : 0 - 15 format
class ZeroToFifteenInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value != null && value >= 1 && value <= 15) {
      return newValue;
    }

    return oldValue;
  }
}
