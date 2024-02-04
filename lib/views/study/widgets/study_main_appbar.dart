import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/theme/app/app_colors.dart';

AppBar studyMainAppBar(BuildContext context, bool isLeader, int studyId) {
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
        offstage: (isLeader == true) ? false : true,
        child: IconButton(
          icon: Image.asset(
            'asset/setting.png',
            width: 32,
            height: 32,
          ),
          onPressed: () => {
            context.push('/studies/$studyId/manage')

          },
        ),
      ),
    ],
  );
}
