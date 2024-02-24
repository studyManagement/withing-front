import 'package:flutter/material.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/views/schedule/study/components/study_schedule_screen_tab.dart';

import '../../../common/theme/app/app_colors.dart';

class StudyScheduleScreen extends StatelessWidget {
  const StudyScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRender = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
