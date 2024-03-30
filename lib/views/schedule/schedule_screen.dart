import 'package:flutter/material.dart';
import 'package:modi/common/components/schedule/schedule_list.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/model/schedule/schedule_group_model.dart';
import 'package:modi/model/schedule/schedule_model.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '일정',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ScheduleList(
          scheduleGroups: [
            ScheduleGroupModel(
              id: 1,
              date: DateTime(2024, 2, 1),
              schedules: [
                ScheduleModel(
                  id: 1,
                  startAt: DateTime(2024, 2, 1, 9),
                  endAt: DateTime(2024, 3, 1, 13),
                  title: '5차 정기 회의',
                  description: '스터디 관리 사이드 프로젝트',
                ),
                ScheduleModel(
                  id: 2,
                  startAt: DateTime(2024, 2, 1, 9),
                  endAt: DateTime(2024, 3, 1, 13),
                  title: '5차 정기 회의',
                  description: '스터디 관리 사이드 프로젝트',
                ),
                ScheduleModel(
                  id: 3,
                  startAt: DateTime(2024, 3, 1, 9),
                  endAt: DateTime(2024, 4, 1, 13),
                  title: '5차 정기 회의',
                  description: '스터디 관리 사이드 프로젝트',
                ),
              ],
            ),
            ScheduleGroupModel(
              id: 2,
              date: DateTime(2024, 3, 1),
              schedules: [
                ScheduleModel(
                  id: 1,
                  startAt: DateTime(2024, 2, 1, 9),
                  endAt: DateTime(2024, 3, 1, 13),
                  title: '5차 정기 회의',
                  description: '스터디 관리 사이드 프로젝트',
                ),
                ScheduleModel(
                  id: 2,
                  startAt: DateTime(2024, 2, 1, 9),
                  endAt: DateTime(2024, 3, 1, 13),
                  title: '5차 정기 회의',
                  description: '스터디 관리 사이드 프로젝트',
                ),
                ScheduleModel(
                  id: 3,
                  startAt: DateTime(2024, 3, 1, 9),
                  endAt: DateTime(2024, 4, 1, 13),
                  title: '5차 정기 회의',
                  description: '스터디 관리 사이드 프로젝트',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
