import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeMyStudy extends StatelessWidget {
  HomeMyStudy({super.key});

  @override
  Widget build(BuildContext context) {
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.studyList);

    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: Text(
            '내 스터디',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.gray800,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: MyStudyList(),
        ),
      ],
    );
  }
}

class MyStudyList extends StatelessWidget {
  const MyStudyList({super.key});

  String getNextScheduleDate(DateTime selectedDate,
      StudyMeetingSchedule currentSchedule, StudyMeetingSchedule nextSchedule) {
    DateFormat dateFormat = DateFormat('yyyy.MM.dd');

    if (currentSchedule.id == nextSchedule.id) {
      return dateFormat.format(selectedDate.add(const Duration(days: 7)));
    }

    if (currentSchedule.day == nextSchedule.day) {
      return dateFormat.format(selectedDate);
    }

    int nextDay = 0;

    if (nextSchedule.day > currentSchedule.day) {
      nextDay = nextSchedule.day - currentSchedule.day;
    } else {
      nextDay = (7 - currentSchedule.day) + nextSchedule.day;
    }

    return dateFormat.format(selectedDate.add(Duration(days: nextDay)));
  }

  @override
  Widget build(BuildContext context) {
    final StudyListViewModel vm = context.read<StudyListViewModel>();
    DateTime selectedDate = context.select<StudyListViewModel, DateTime>(
        (provider) => provider.selectedDate);
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.studyList);

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: studies.length,
      itemBuilder: (context, index) {
        final item = studies[index];
        final StudyMeetingSchedule nextMeetingSchedule =
            vm.getNextPromise(item);
        final String nextScheduleDate = getNextScheduleDate(
            selectedDate, item.meetingSchedules.first, nextMeetingSchedule);

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => context.push('/studies/${item.id}'),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: const BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StudyImage(),
                const SizedBox(height: 10),
                Text(
                  item.studyName,
                  style: const TextStyle(
                    color: AppColors.gray800,
                    fontSize: 16,
                    fontWeight: AppFonts.fontWeight600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '매주 (${item.getAllWeekdays()}) ${item.getPromiseByDefault().startTime}',
                  style: const TextStyle(
                    color: AppColors.gray400,
                    fontWeight: AppFonts.fontWeight500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StudyImage extends StatelessWidget {
  const StudyImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 42,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.network(
              'https://picsum.photos/42',
              width: 42,
              height: 42,
            ),
          ),
          Positioned(
            top: -3,
            right: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.gray50,
                  width: 3,
                ),
                color: AppColors.red400,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
