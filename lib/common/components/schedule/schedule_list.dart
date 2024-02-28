import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/schedule/schedule_list_item.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/model/schedule/schedule_group_model.dart';

class ScheduleList extends StatelessWidget {
  final List<ScheduleGroupModel> scheduleGroups;
  const ScheduleList({
    super.key,
    required this.scheduleGroups,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: scheduleGroups.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                DateFormat.MMMd('ko').format(scheduleGroups[index].date),
                style: const TextStyle(
                  fontWeight: AppFonts.fontWeight600,
                  fontSize: AppFonts.fontSize14,
                  color: AppColors.gray600,
                ),
              ),
            ),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int childIndex) {
                return Wrap(
                  children: [
                    ScheduleListItem(
                      barColor: AppColors.gray150,
                      startAt:
                          scheduleGroups[index].schedules[childIndex].startAt,
                      endAt: scheduleGroups[index].schedules[childIndex].endAt,
                      title: scheduleGroups[index].schedules[childIndex].title,
                      description: scheduleGroups[index]
                          .schedules[childIndex]
                          .description,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 9.5),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.gray50,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
