import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/bottom_shadow.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:modi/views/home/components/home_study_notificator_v2.dart';
import 'package:modi/views/home/home_my_study.dart';
import 'package:provider/provider.dart';

import '../../common/layout/default_layout.dart';
import 'main_calendar_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
    final StudyListViewModel vm = context.watch<StudyListViewModel>();
    vm.fetchThisWeekSchedules();

    void onDaySelected(DateTime selectedDate, DateTime focusedDate) { // 그날 일정만 보여 주기
      setState(() {
        this.selectedDate = selectedDate;
        vm.fetchStudies(StudyType.MY);
        vm.filterSchedules(selectedDate);
        vm.setSelectedDate(this.selectedDate);
      });
    }
    onDaySelected(selectedDate, selectedDate);

    return DefaultLayout(
      title: '이번주 일정',
      centerTitle: false,
      titleFontSize: 20,
      titleBottom: BottomShadow(
        child: MainCalendarV2(
          onDaySelected: onDaySelected,
          selectedDate: selectedDate,
        ),
      ),
      // actions: [
      //   CircleButton(
      //     onTap: () => context.push('/notification'),
      //     image: Image.asset('asset/bell.png', width: 32, height: 32),
      //   ),
      // ],
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
