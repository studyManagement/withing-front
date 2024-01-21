import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import '../../../view_models/create/create_study_viewmodel.dart';

class StudyDiscloseToggle extends StatelessWidget {
  const StudyDiscloseToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateStudyViewModel>(context);
    final bool isToggled = viewModel.isStudyDiscloseToggled;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '비공개 설정',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.gray500),
              ),
              Switch(
                activeColor: AppColors.blue400,
                activeTrackColor: AppColors.gray150,
                inactiveThumbColor: AppColors.gray400,
                inactiveTrackColor: AppColors.gray150,
                value: isToggled,
                onChanged: (_) => viewModel.toggle(),
              ),
            ],
          ),
          if (isToggled)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '비밀번호',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.gray500),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '숫자 4자리',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.gray300,
                              fontSize: 13.0,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 54,
                  height: 22,
                  child: TextField(
                    onChanged: (value) {
                      if (value != '') viewModel.password = value;
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '0000',
                      hintStyle:
                          Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: AppColors.gray200,
                              ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gray150),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gray150),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gray150),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gray150),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    cursorHeight: 16,
                    cursorWidth: 1.5,
                    cursorColor: AppColors.blue500,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
