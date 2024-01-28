import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/view_models/study/study_list_viewmodel.dart';
import 'package:withing/views/home/components/home_study_notificator.dart';

import '../../common/layout/default_layout.dart';
import './main_calendar.dart';
import 'home_my_study.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    final StudyListViewModel vm = context.read<StudyListViewModel>();

    void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
      vm.fetchStudies(StudyType.MY);
      vm.setSelectedDate(selectedDate);
    }

    onDaySelected(selectedDate, selectedDate);

    return DefaultLayout(
      title: '이번주 일정',
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 280,
              child: Column(
                children: [
                  MainCalendar(
                    onDaySelected: onDaySelected,
                    selectedDate: selectedDate,
                  ),
                  HomeStudyNotificationPageView(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              thickness: 5,
              height: 1,
              color: Colors.grey[200],
            ),
            HomeMyStudy(),
          ],
        ),
      ),
    );
  }
}
