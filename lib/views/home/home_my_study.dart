import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeMyStudy extends StatelessWidget {
  HomeMyStudy({super.key});

  final _valueList = ['가입한 순', '인기 순', '최신 순'];
  final _selectValue = '가입한 순';

  @override
  Widget build(BuildContext context) {
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.selectStudyListView);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '내 스터디',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray800,
                  ),
                ),
                // DropdownMenuItem,
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectValue,
                    items: _valueList.map(
                      (val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                studies.isNotEmpty
                    ? const MyStudyList()
                    : const SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 120),
                            MyStudyListException(),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyStudyListException extends StatelessWidget {
  const MyStudyListException({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      constraints: const BoxConstraints(maxHeight: 72),
      child: Column(
        children: [
          Image.asset('asset/exclamation.png', width: 40, height: 40),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '진행 중인 스터디가 없어요.',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
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
    String weekString = context
        .select<StudyListViewModel, String>((provider) => provider.weekString);
    DateTime selectedDate = context.select<StudyListViewModel, DateTime>(
        (provider) => provider.selectedDate);
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.selectStudyListView);

    return Expanded(
        child: ListView.separated(
      itemBuilder: (_, index) {
        final item = studies[index];
        final StudyMeetingSchedule nextMeetingSchedule =
            vm.getNextPromise(item);
        final String nextScheduleDate = getNextScheduleDate(
            selectedDate, item.meetingSchedules.first, nextMeetingSchedule);

        return InkWell(
          onTap: () {
            context.push("/studies/${item.id}");
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    StudyImage(),
                    const SizedBox(width: 8),
                    Text(
                      item.studyName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      '정기 모임',
                      style: TextStyle(
                        color: AppColors.gray400,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '매주 $weekString요일 ${item.getPromise(selectedDate).startTime}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColors.gray800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      '다음 만남',
                      style: TextStyle(
                        color: AppColors.gray400,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$nextScheduleDate (${WeekString[nextMeetingSchedule.day - 1]}) ${nextMeetingSchedule.startTime}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColors.gray800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, index) => const Divider(
        height: 10,
        color: AppColors.gray100,
        thickness: 1,
        indent: 20,
        endIndent: 20,
      ),
      itemCount: studies.length,
    ));
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
                  color: AppColors.white,
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
