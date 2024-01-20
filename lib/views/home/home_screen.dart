import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';
import 'package:withing/views/home/components/home_study_notificator.dart';

import '../../common/layout/default_layout.dart';
import './main_calendar.dart';
import 'home_my_study.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StudyViewModel vm = context.read<StudyViewModel>();

    vm.fetchStudies(StudyType.MY);
    vm.setSelectedDate(selectedDate);

    return DefaultLayout(
      title: '이번주 일정',
      child: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              onDaySelected: onDaySelected,
              selectedDate: selectedDate,
            ),
            HomeStudyNotificator(),
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

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
      StudyViewModel vm = context.read<StudyViewModel>();
      vm.fetchStudies(StudyType.MY);
      vm.setSelectedDate(selectedDate);
    });
  }
}
