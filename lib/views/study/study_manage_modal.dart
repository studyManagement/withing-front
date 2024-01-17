import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/components/modal_button.dart';
import 'package:withing/common/theme/theme_resources.dart';

void showStudyFinishDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding:
              const EdgeInsets.only(left: 12, right: 12, top: 27, bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text(
            "스터디를 종료하시겠어요?",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          content: SizedBox(
            width: 291,
            height: 40,
            child: Text(
              "더 이상 스터디를 진행할 수 없으며,\n종료된 스터디에 저장돼요.",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          actionsPadding:
              const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
          actions: <Widget>[
            Row(
              children: [
                ModalButton(
                    onTap: () {
                      context.pop();
                    },
                    text: "취소",
                    backgroundcolor: AppColors.blue200),
                const SizedBox(width: 5),
                ModalButton(
                    onTap: () {},
                    text: "스터디 종료",
                    backgroundcolor: AppColors.blue600),
              ],
            ),
          ],
        );
      });
}

void showStudyDeleteDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: AlertDialog(
          titlePadding:
              const EdgeInsets.only(left: 12, right: 12, top: 27, bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text(
            "스터디를 삭제하시겠어요?",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          content: SizedBox(
            width: 291,
            height: 40,
            child: Text(
              "스터디가 영구적으로 삭제되며,\n복구할 수 없어요.",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          actionsPadding:
              const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
          actions: <Widget>[
            Row(
              children: [
                ModalButton(
                    onTap: () {
                      context.pop();
                    },
                    text: "취소",
                    backgroundcolor: AppColors.blue200),
                const SizedBox(width: 5),
                ModalButton(
                    onTap: () {},
                    text: "스터디 삭제",
                    backgroundcolor: AppColors.red400),
              ],
            ),
          ],
        ));
      });
}
