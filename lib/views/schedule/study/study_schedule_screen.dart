import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/views/schedule/study/components/study_schedule_screen_tab.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/icon_text_button.dart';

class StudyScheduleScreen extends StatelessWidget {
  const StudyScheduleScreen(this._studyId, {super.key});

  final int _studyId;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '일정',
      resizeToAvoidBottomInset: false,
      leader: CircleButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onTap: () => Navigator.of(context).pop(),
      ),
      actions: [
        if(StudyViewModel.leaderId == Authentication.instance.userId)
        CircleButton(
          onTap: () {
            ModiModal.openBottomSheet(
              context,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTextButton(
                    140,
                    Image.asset('asset/add_schedule.png',
                        width: 90, height: 90),
                    '일정 등록',
                    () {
                      context.pop();
                      context.push('/studies/$_studyId/schedules/register');
                    },
                  ),
                  const SizedBox(width: 11),
                  IconTextButton(
                    140,
                    Image.asset('asset/vote_schedule.png',
                        width: 90, height: 90),
                    '일정 투표',
                    () {
                      context.pop();
                      context.push('/studies/$_studyId/schedules/vote');
                    },
                  ),
                ],
              ),
              height: 200,
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StudyScheduleScreenTab(studyId: _studyId),
      ),
    );
  }
}
