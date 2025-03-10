import 'package:flutter/material.dart';
import 'package:modi/model/schedule/user_schedule_model.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/theme/app/app_colors.dart';

class MainCalendarV2 extends StatelessWidget {
  final Function(DateTime) onDaySelected;
  final DateTime selectedDate;

  const MainCalendarV2({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    List<String> weekDays = ['일', '월', '화', '수', '목', '금', '토'];
    List<DateTime> weekDateTimes = [];
    StudyListViewModel viewModel = context.watch<StudyListViewModel>();
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (now.weekday == 7) {
        weekDateTimes.add(now.add(Duration(days: i)));
      } else {
        weekDateTimes.add(now.subtract(Duration(days: now.weekday - i)));
      }
    }
    List<UserScheduleModel> schedules =
        context.select<StudyListViewModel, List<UserScheduleModel>>(
            (provider) => provider.thisWeekSchedules); // 이번주 일정
    
    bool hasStudies(DateTime weekDateTime) {
      int weekday = weekDateTime.weekday;
      return schedules.where((e) => DateTime.parse(e.date).weekday == weekday).isNotEmpty;
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          for (int i = 0; i < 7; i++)
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    onDaySelected(weekDateTimes[i]);
                  },
                  child: Container(

                      height: 67,
                      decoration: (selectedDate.day == weekDateTimes[i].day)
                          ? BoxDecoration(
                              color: AppColors.blue600,
                              borderRadius: BorderRadius.circular(8))
                          : const BoxDecoration(color: Colors.transparent),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            weekDays[i],
                            style: TextStyle(
                                color: (viewModel.selectedDate.day ==
                                        weekDateTimes[i].day)
                                    ? Colors.white
                                    : AppColors.gray400),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            weekDateTimes[i].day.toString(),
                            style: TextStyle(
                              color: (selectedDate.day == weekDateTimes[i].day)
                                  ? Colors.white
                                  : (i == 0)
                                      ? AppColors.red400
                                      : ((i == 6)
                                          ? AppColors.blue400
                                          : AppColors.gray800),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: hasStudies(weekDateTimes[i]) // hasStudy
                                  ? (selectedDate.day == weekDateTimes[i].day
                                      ? AppColors.white
                                      : AppColors.gray200)
                                  : Colors.transparent,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ],
                      ))),
            )
        ]));
  }
}
