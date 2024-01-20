import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';
import 'package:go_router/go_router.dart';

AppBar StudyMainAppBar(BuildContext context, bool isLeader) {
  return AppBar(
    backgroundColor: AppColors.white,
    leading: IconButton(
      icon: Image.asset(
        'asset/arrowback.png',
        width: 32,
        height: 32,
      ),
      onPressed: () =>
      {
        context.pop()
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
            context.push('/studies/:studyId/manage')
          },
        ),
      ),
    ],
  );
}