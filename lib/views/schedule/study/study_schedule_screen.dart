import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/views/schedule/study/components/study_schedule_screen_tab.dart';

import '../../../common/components/button/icon_text_button.dart';

class StudyScheduleScreen extends StatelessWidget {
  const StudyScheduleScreen(this._studyId, {super.key});

  final int _studyId;

  @override
  Widget build(BuildContext context) {
    bool isRender = true;
    return DefaultLayout(
      title: '일정',
      resizeToAvoidBottomInset: false,
      leader: CircleButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onTap: () => Navigator.of(context).pop(),
      ),
      actions: [
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
                      () => context
                          .push('/studies/$_studyId/schedules/register')),
                  const SizedBox(width: 11),
                  IconTextButton(
                      140,
                      Image.asset('asset/vote_schedule.png',
                          width: 90, height: 90),
                      '일정 투표',
                      () => context.push('/studies/$_studyId/schedules/vote')),
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
        child: (!isRender)
            ? ModiException(const ['생성된 일정이 없어요.'])
            : StudyScheduleScreenTab(studyId: _studyId),
      ),
    );
  }
}
