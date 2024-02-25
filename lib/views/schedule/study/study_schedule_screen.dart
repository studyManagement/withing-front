import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/views/schedule/study/components/study_schedule_screen_tab.dart';

import '../../../common/components/button/icon_text_button.dart';

class StudyScheduleScreen extends StatelessWidget {
  const StudyScheduleScreen(this._studyId, {super.key});

  final int _studyId;

  @override
  Widget build(BuildContext context) {
    bool isRender = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
              onPressed: () {
                ModiModal.openBottomSheet(
                  context,
                  Row(
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
                          () => context
                              .push('/studies/$_studyId/schedules/vote')),
                    ],
                  ),
                  200,
                );
              },
              icon: const Icon(Icons.add)),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '일정',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: (!isRender)
              ? ModiException(const ['생성된 일정이 없어요.'])
              : const StudyScheduleScreenTab(),
        ),
      ),
    );
  }
}
