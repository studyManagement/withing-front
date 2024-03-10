import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:modi/views/home/components/home_study_notificator_v2.dart';
import 'package:modi/views/home/home_my_study.dart';
import 'package:provider/provider.dart';

import '../../common/layout/default_layout.dart';
import './main_calendar.dart';

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

    DateTime selectedDate = context.select<StudyListViewModel, DateTime>(
        (provider) => provider.selectedDate);
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.selectStudyListView);

    void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
      vm.fetchStudies(StudyType.MY);
      vm.setSelectedDate(selectedDate);
    }

    onDaySelected(selectedDate, selectedDate);

    List<Widget> homeWidgets = [];
    if (studies.isNotEmpty) {
      homeWidgets.addAll(
        [
          Container(
            decoration: const BoxDecoration(color: Color(0x00E0E8F0)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: HomeStudyNotificaticator(),
          ),
          const Divider(
            thickness: 5,
            height: 1,
            color: AppColors.gray50,
          ),
        ],
      );
    }

    homeWidgets.add(HomeMyStudy());

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
          children: homeWidgets,
        ),
      ),
    );
  }
}
