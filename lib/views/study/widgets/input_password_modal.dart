import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';

class InputPasswordModal extends StatelessWidget {
  final int studyId;

  InputPasswordModal({super.key, required this.studyId});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final StudyViewModel vm = context.watch<StudyViewModel>();


    final FocusNode _focusNode = FocusNode();

    void _requestFocus() {
      FocusScope.of(context).requestFocus(_focusNode);
    }
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      titlePadding: const EdgeInsets.only(top: 27, bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(
        '비밀번호 입력',
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      content: SizedBox(
        height: 70,
        child: Column(
          children: [
            Text(
              vm.getPasswordErrorText(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      (vm.isErrorText) ? AppColors.red400 : AppColors.gray500),
              textAlign: TextAlign.center,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                TextField(
                  controller: _controller,
                  autofocus: true,
                  focusNode: _focusNode,
                  showCursor: false,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.transparent),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  onChanged: (String data) {
                    _requestFocus();
                    vm.renderObscuringChar(data);
                  },
                  onSubmitted: (String data) {
                    vm.isValidPassword().then((_) => {
                          if (vm.successToJoin)
                            {context.go('/studies/$studyId')},
                          _controller.clear()
                        });
                  },
                ),
                Positioned(
                  top: 20,
                  child: Wrap(
                    spacing: 16,
                    children: [
                      for (int i = 0; i < 4; i++)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                color: (vm.isFilled[i])
                                    ? AppColors.blue600
                                    : AppColors.gray200),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      actionsPadding:
          const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
      actions: <Widget>[
        Row(
          children: [
            ConfirmButton(
              onTap: () {
                context.pop();
              },
              text: '취소',
              backgroundColor: AppColors.blue200,
              width: 143,
            ),
            const SizedBox(width: 5),
            ConfirmButton(
                onTap: () {
                  vm.isValidPassword().then((_) => {
                        if (vm.successToJoin)
                          {context.go('/studies/$studyId')},
                    _controller.clear()
                      });
                },
                text: '확인',
                backgroundColor: AppColors.blue600,
                width: 143),
          ],
        ),
      ],
    );
  }
}
