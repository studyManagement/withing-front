import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/view_models/search/searched_studies_viewmodel.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../common/components/image/circle_image.dart';
import '../../common/utils/get_regular_meeting_string.dart';

class HomeMyStudy extends StatelessWidget {
  HomeMyStudy({super.key});

  @override
  Widget build(BuildContext context) {
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.studyList);

    List<Widget> homeWidgets = [];
    if (studies.isEmpty) {
      homeWidgets.add(
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ModiException(const ['등록된 스터디가 없어요.']),
        ),
      );
    } else {
      homeWidgets.addAll([
        const Padding(
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: MyStudyList(),
        ),
      ]);
    }

    return Column(
      mainAxisAlignment: (studies.isEmpty)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: (studies.isEmpty)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: homeWidgets,
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

        // String regularMeeting = (item.meetingSchedules.isNotEmpty)
        //     ? '매주 (${item.getAllWeekdays()}) ${item.getPromiseByDefault().startTime}'
        //     : "비정기 모임";
        String regularMeeting = getRegularMeetingString(item.meetingSchedules);

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
                StudyImage(item.studyImage),
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
                  regularMeeting,
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
  const StudyImage(
    this.studyImage, {
    super.key,
  });

  final String? studyImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white,
                width: 3,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleImage(
              size: 42,
              image: (studyImage == null)
                  ? null
                  : Image.network(
                      fit: BoxFit.cover,
                      studyImage!,
                      width: 42,
                      height: 42,
                    ),
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
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
