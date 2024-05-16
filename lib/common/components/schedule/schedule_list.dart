import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/schedule/schedule_list_item.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/model/schedule/schedule_group_model.dart';
import 'package:modi/view_models/schedule/user/user_schedule_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../model/schedule/user_schedule_model.dart';

class ScheduleList extends StatelessWidget {
  final UserScheduleViewModel? viewModel;
  const ScheduleList({
    super.key,
    this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserScheduleViewModel>();
    List<List<UserScheduleModel>> scheduleGroups = viewModel.scheduleListSplitByDate;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent) {
          viewModel.scrollListener(context);
        }
        return true;
      },
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= scheduleGroups.length) {
                  return Container();
                }
               viewModel.getHeaderString(scheduleGroups[index].first.date);
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
                                viewModel.headerString,
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ...scheduleGroups[index]
                        .map((schedule) => ScheduleListItem(
                              studyName: schedule.studyName,
                              scheduleName: schedule.scheduleName,
                              isLast: false, // 추후
                              startTime: viewModel.get12hourString(schedule.startTime),
                              endTime: viewModel.get12hourString(schedule.endTime),
                            ))
                        .toList(),
                  ],
                );
              },
              childCount: viewModel.entireLength,
            ),
          ),
        ],
      ),
    );
  }
}
