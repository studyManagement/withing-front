import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    List<StudyView> studies = context.select<StudyViewModel, List<StudyView>>(
        (provider) => provider.studyViews);
    DateTime selectedStudyDate = context
        .select<StudyViewModel, DateTime>((provider) => provider.selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      child: TableCalendar(
        locale: 'ko_kr',
        headerVisible: false,
        onDaySelected: onDaySelected,
        selectedDayPredicate: (date) =>
            date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day,
        focusedDay: selectedDate,
        firstDay: DateTime(1900, 1, 1),
        lastDay: DateTime(2300, 1, 1),
        calendarFormat: CalendarFormat.week,
        calendarBuilders: CalendarBuilders(
          todayBuilder: (context, dateTime, event) {
            return Container(
                height: 120,
                width: 200,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      dateTime.day.toString(),
                      style: TextStyle(
                        color: (dateTime.weekday == 7)
                            ? AppColors.red400
                            : ((dateTime.weekday == 6)
                                ? AppColors.blue400
                                : AppColors.gray800),
                      ),
                    ),
                  ],
                ));
          },
          defaultBuilder: (context, dateTime, event) {
            return Container(
                height: 120,
                width: 200,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      dateTime.day.toString(),
                      style: TextStyle(
                        color: (dateTime.weekday == 7)
                            ? AppColors.red400
                            : ((dateTime.weekday == 6)
                                ? AppColors.blue400
                                : AppColors.gray800),
                      ),
                    ),
                  ],
                ));
          },
          selectedBuilder: (context, dateTime, event) {
            return Container(
                height: 120,
                width: 44,
                decoration: (dateTime.weekday == selectedStudyDate.weekday)
                    ? const BoxDecoration(
                        color: AppColors.blue600,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)))
                    : const BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      dateTime.day.toString(),
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ],
                ));
          },
          markerBuilder: (context, dateTime, event) {
            log('[DEBUG MSG] ${(studies.toString())}');
            bool hasStudy = studies
                .where((element) => element.hasSelectedDay(dateTime))
                .isNotEmpty;
            return Column(
              children: [
                const SizedBox(height: 36),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: (hasStudy)
                        ? ((selectedStudyDate.weekday == dateTime.weekday)
                            ? AppColors.white
                            : AppColors.blue600)
                        : Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            );
          },
          dowBuilder: (context, dateTime) {
            return Row(
              children: [
                const Expanded(child: SizedBox()),
                Container(
                  constraints: const BoxConstraints(maxWidth: 50),
                  width: 44,
                  decoration: (dateTime.weekday == selectedStudyDate.weekday &&
                          dateTime.month == selectedStudyDate.month &&
                          dateTime.day == selectedStudyDate.day)
                      ? const BoxDecoration(
                          color: AppColors.blue600,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)))
                      : const BoxDecoration(color: Colors.transparent),
                  child: Center(
                    child: Text(
                      DateFormat('E', 'ko_KR').format(dateTime),
                      style: const TextStyle(
                        color: AppColors.gray300,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            );
          },
        ),
      ),
    );
  }
}
