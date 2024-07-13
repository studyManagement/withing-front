import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/model/schedule/user_schedule_model.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeStudyNotificator extends StatelessWidget {
  const HomeStudyNotificator(this.selectedDate, {super.key});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    List<UserScheduleModel> schedules =
        context.select<StudyListViewModel, List<UserScheduleModel>>(
            (provider) => provider.todaySchedules);
    
    return schedules.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: HomeStudyNotificatorList(selectedDate, schedules),
          )
        : Container(
            decoration: const BoxDecoration(color: AppColors.gray50),
            height: 104,
            width: MediaQuery.of(context).size.width,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '등록된 일정이 없어요',
                  style: TextStyle(
                    color: AppColors.gray300,
                    fontWeight: AppFonts.fontWeight500,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          );
  }
}

class HomeStudyNotificatorList extends StatelessWidget {
  const HomeStudyNotificatorList(this.selectedDate, this.schedules, {super.key});

  final DateTime selectedDate;
  final List<UserScheduleModel> schedules;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.separated(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          UserScheduleModel study = schedules[index];
         final hours = [int.parse(study.startTime.split(":")[0]), int.parse(study.endTime.split(":")[0])];
         final mins = [study.startTime.split(":")[1], study.endTime.split(":")[1]];
            String start = (hours[0] < 12) ? '오전 ${study.startTime}' : '오후 ${(hours[0]-12).toString().padLeft(2,'0')}:${mins[0]}';
           String end = (hours[1] < 12) ? '오전 ${study.endTime}' : '오후 ${(hours[1]-12).toString().padLeft(2,'0')}:${mins[1]}';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${start} - ${end}',
                style: const TextStyle(
                  color: AppColors.gray600,
                  fontWeight: AppFonts.fontWeight500,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                study.scheduleName,
                style: const TextStyle(
                  color: AppColors.gray800,
                  fontWeight: AppFonts.fontWeight600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                study.studyName,
                style: const TextStyle(
                  color: AppColors.gray400,
                  fontWeight: AppFonts.fontWeight600,
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              thickness: 1,
              color: AppColors.gray100,
            ),
          );
        },
        itemCount: schedules.length,
      ),
    );
  }
}
