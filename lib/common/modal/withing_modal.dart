import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/study_modal.dart';

class WithingModal {
  static void openDialog(BuildContext context, String title, String content,
      bool isCancel, Function()? onOk, Function()? onCancel) {
    showDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StudyModal(
              title: title,
              content: content,
              isCancel: isCancel,
              onOk: (onOk == null)
                  ? () {
                      context.pop();
                    }
                  : onOk,
              onCancel: (onCancel == null)
                  ? () {
                      context.pop();
                    }
                  : onCancel);
        });
  }
}
