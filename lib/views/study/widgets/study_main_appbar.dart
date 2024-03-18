import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/share/share.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

class StudyMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int studyId;
  final bool isLeader;
  final Function()? action;

  const StudyMainAppBar(
      {super.key, required this.studyId, required this.isLeader, this.action});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => {
          if (studyId == -1) {context.go('/')} else {context.pop()}
        },
      ),
      centerTitle: true,
      foregroundColor: AppColors.black,
      elevation: 0,
      actions: <Widget>[makeShareButton(context), makeLikeButton(context)],
    );
  }

  Widget makeShareButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        ModiModal.openBottomSheet(
          context,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Share(
              title: '초대가 왔어요!',
              message: '가입 후 스터디를 시작해보세요\n\nhttps://modi.tips/s/GnvfgYAE',
              path: '',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          height: 221,
        );
      },
      icon: Image.asset('asset/share.png'),
    );
  }

  Widget makeLikeButton(BuildContext context) {
    final viewModel = context.watch<StudyViewModel>();
    return (viewModel.isMember)
        ? Offstage(
            offstage: (isLeader) ? false : true,
            child: IconButton(
              icon: Image.asset(
                'asset/setting.png',
                width: 32,
                height: 32,
              ),
              onPressed: action,
            ),
          )
        : IconButton(
            icon: (viewModel.hasLike)
                ? Image.asset(
                    'asset/heart_filled_32.png',
                    width: 32,
                    height: 32,
                  )
                : Image.asset(
                    'asset/heart_lined_32.png',
                    width: 32,
                    height: 32,
                  ),
            onPressed: () {
              (viewModel.hasLike)
                  ? viewModel.cancelFavoriteStudy()
                  : viewModel.pickFavoriteStudy();
            },
          );
  }
}
