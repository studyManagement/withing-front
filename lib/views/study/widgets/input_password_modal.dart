import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/modal/modi_modal.dart';
import '../../../common/theme/app/app_colors.dart';

class InputPasswordModal extends StatefulWidget {
  final int studyId;

  const InputPasswordModal({super.key, required this.studyId});

  @override
  State<InputPasswordModal> createState() => _State();
}

class _State extends State<InputPasswordModal> {
  final TextEditingController _controller = TextEditingController();
  String password = '';
  List<bool> isFilled = [for (int i = 0; i < 4; i++) false];
  List<String> helperText = ['스터디 가입을 위해 필요해요.', '잘못된 비밀번호에요.'];

  @override
  Widget build(BuildContext context) {
    final StudyViewModel vm = context.watch<StudyViewModel>();
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      titlePadding:
          const EdgeInsets.only(top: 27, bottom: 8),
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
              (!vm.checkPwd) ? helperText[1] : helperText[0],
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: (vm.checkPwd) ? AppColors.gray500 : AppColors.red400),
              textAlign: TextAlign.center,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                TextField(
                  controller: _controller,
                  autofocus: true,
                  showCursor: false,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.transparent),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  onChanged: (String data) {
                    renderObscuringChar(data);
                    password = data;
                  },
                  onSubmitted: (String data) {
                    password = data;
                    if (password.isEmpty || password.length < 4) {
                      print('비밀번호를 입력해주세요.');
                    } else {
                      joinToPrivateStudy(vm, context, password);
                    }
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
                                color: (isFilled[i])
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
                  if (password.isEmpty || password.length < 4) {
                    print('비밀번호를 입력해주세요.');
                  } else {
                    joinToPrivateStudy(vm, context, password);
                  }
                },
                text: '확인',
                backgroundColor: AppColors.blue600,
                width: 143),
          ],
        ),
      ],
    );
  }

  void joinToPrivateStudy(
      StudyViewModel vm, BuildContext context, String password) {
    vm.joinStudy(widget.studyId, password);
    if (vm.successToJoin) {
      print('가입 성공');
      context.go('/studies/${widget.studyId}');
    } else {
      ModiModal.openDialog(
          context, '스터디 가입 실패', '', false, () => null, () => null);
    }
  }

  void renderObscuringChar(String password) {
    for (int i = 1; i <= 4; i++) {
      setState(() {
        if (i <= password.length) {
          isFilled[i - 1] = true;
        } else {
          isFilled[i - 1] = false;
        }
      });
    }
  }
}
