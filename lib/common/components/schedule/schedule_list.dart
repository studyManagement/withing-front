import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/schedule/schedule_list_item.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/model/schedule/schedule_group_model.dart';

class ScheduleList extends StatelessWidget {
  final List<ScheduleGroupModel> scheduleGroups;

  const ScheduleList({
    super.key,
    required this.scheduleGroups,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 44.0,
                    child: ColoredBox(
                      color: AppColors.gray50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 22.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat.MMMMEEEEd('ko')
                                  .format(DateTime.parse('2024-02-02')),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: AppFonts.fontSize14,
                                color: AppColors.gray600,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1F3358),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      '오늘',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      DateFormat('MM.dd')
                                          .format(DateTime.now())
                                          .toString(),
                                      style: const TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...scheduleGroups[index]
                      .schedules
                      .map((schedule) => ScheduleListItem(
                            key: Key(schedule.id.toString()),
                            id: schedule.id,
                            title: schedule.title,
                            description: schedule.description,
                            isLast: scheduleGroups[index].schedules.last.id ==
                                schedule.id,
                            startAt: schedule.startAt,
                            endAt: schedule.endAt,
                          ))
                      .toList(),
                ],
              );
            },
            childCount: scheduleGroups.length,
          ),
        ),
      ],
    );
  }
}
