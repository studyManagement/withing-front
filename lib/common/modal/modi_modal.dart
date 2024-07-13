import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/modal/bottom/modi_bottom_sheet.dart';
import 'package:modi/common/components/modal/confirm/study_modal.dart';
import 'package:modi/common/modal/action_sheet_params.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class ModiModal {
  static void openDialog(BuildContext context, String title, String content,
      bool isCancel, Function()? onOk, Function()? onCancel,
      {String? leftText, String? rightText, Color? leftColor, Color? rightColor}) {
    showDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StudyModal(
              title: title,
              leftText: leftText,
              leftColor: leftColor,
              rightColor: rightColor,
              rightText: rightText,
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

  static void openBottomSheet(BuildContext context,
      {required Widget widget, required double height}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ModiBottomSheet(widget, height);
      },
    );
  }

  static void openActionSheet(
      BuildContext context, List<ActionSheetParams> params) {
    openBottomSheet(
      context,
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: 18),
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Text(
                params[index].title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: AppFonts.fontWeight500,
                  color: params[index].titleColor ?? AppColors.gray900,
                ),
              ),
              onTap: () {
                params[index].onTap();
                context.pop();
              },
            );
          },
          itemCount: params.length,
        ),
      ),
      height: 52 + (params.length * 40.0),
    );
  }
}
