import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/bottom_toast.dart';

import '../../../common/modal/withing_modal.dart';
import '../../../common/theme/app/app_colors.dart';

class BoardBottomSheet extends StatelessWidget {
  const BoardBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 26),
        GestureDetector(
          child: Text('공지로 등록하기', style: Theme.of(context).textTheme.bodySmall),
          onTap: () {
            context.pop();
            BottomToast(context: context, text: "공지로 등록되었어요.").show();
          },
        ),
        const SizedBox(height: 12),
        GestureDetector(
          child: Text('수정하기', style: Theme.of(context).textTheme.bodySmall),
          onTap: () {
            // 수정 화면 이동
          },
        ),
        const SizedBox(height: 12),
        GestureDetector(
          child: Text('삭제하기',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.red400)),
          onTap: () {
            WithingModal.openDialog(
                context, "\n게시글을 삭제하시겠어요?", '', false, () => null, () => null);
          },
        ),
      ]),
    );
  }
}
