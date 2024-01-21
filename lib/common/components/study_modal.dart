import 'package:flutter/material.dart';
import 'package:withing/common/theme/app/app_colors.dart';

import 'modal_button.dart';

class StudyModal extends StatelessWidget {
  final String title;
  final String content;
  final bool isCancel;
  final Function() onOk;
  final Function() onCancel;

  const StudyModal(
      {required this.title,
      required this.content,
      required this.isCancel,
      required this.onOk,
      required this.onCancel,
      super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [
      ModalButton(onTap: onCancel, text: '취소', backgroundcolor: AppColors.blue200),
    ];

    if (isCancel) {
      buttons.addAll([
        const SizedBox(width: 5),
        ModalButton(
            onTap: onOk, text: '확인', backgroundcolor: AppColors.red400),
      ]);
    }

    return AlertDialog(
      surfaceTintColor: Colors.white,
      titlePadding:
          const EdgeInsets.only(left: 12, right: 12, top: 27, bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      content: SizedBox(
        width: 291,
        height: 40,
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
      actionsPadding:
          const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
      actions: <Widget>[
        Row(
          children: buttons,
        ),
      ],
    );
  }
}
