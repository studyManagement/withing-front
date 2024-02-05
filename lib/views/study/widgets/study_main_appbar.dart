import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/theme/app/app_colors.dart';

class StudyMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int studyId;
  final int leaderId;

  const StudyMainAppBar(
      {super.key, required this.studyId, required this.leaderId});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => {
          if (studyId == -1) {context.go('/home')} else {context.pop()}
        },
      ),
      centerTitle: true,
      foregroundColor: AppColors.black,
      elevation: 0,
      actions: <Widget>[
        Offstage(
          offstage: (leaderId == 24) ? false : true,
          child: IconButton(
            icon: Image.asset(
              'asset/setting.png',
              width: 32,
              height: 32,
            ),
            onPressed: () => {context.push('/studies/$studyId/manage')},
          ),
        ),
      ],
    );
  }
}
