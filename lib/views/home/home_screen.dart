import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:modi/views/home/components/home_study_notificator_v2.dart';
import 'package:modi/views/home/home_my_study.dart';
import 'package:provider/provider.dart';

import '../../common/layout/default_layout.dart';
import './main_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  @override
  Widget build(BuildContext context) {
    final StudyListViewModel vm = context.read<StudyListViewModel>();

    void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
      setState(() {
        this.selectedDate = selectedDate;
        vm.fetchStudies(StudyType.MY);
        vm.setSelectedDate(this.selectedDate);
      });
    }

    onDaySelected(selectedDate, selectedDate);

    return DefaultLayout(
      title: '이번주 일정',
      centerTitle: false,
      titleFontSize: 20,
      titleBottom: MainCalendar(
        onDaySelected: onDaySelected,
        selectedDate: selectedDate,
      ),
      actions: [
        IconButton(
          onPressed: () => context.push('/notification'),
          icon: Image.asset('asset/bell.png'),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeStudyNotificator(selectedDate),
            const Divider(
              thickness: 5,
              height: 1,
              color: AppColors.gray50,
            ),
            HomeMyStudy(),
          ],
        ),
      ),
    );
  }
}
