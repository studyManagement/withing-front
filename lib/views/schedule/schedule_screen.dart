import 'package:flutter/material.dart';
import 'package:modi/common/components/bottom_shadow.dart';
import 'package:modi/common/components/schedule/schedule_list.dart';
import 'package:modi/common/components/schedule/schedule_list_item.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/model/schedule/schedule_group_model.dart';
import 'package:modi/model/schedule/schedule_model.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '일정',
      elevation: 10,
      appBarShadowColor: Color.fromARGB(40, 0, 0, 0),
      child: ScheduleList(
        scheduleGroups: [
          ScheduleGroupModel(
            id: 1,
            date: DateTime(2024, 2, 22),
            schedules: [
              ScheduleModel(
                id: 1,
                startAt: DateTime(2024, 2, 22, 9),
                endAt: DateTime(2024, 2, 22, 13),
                title: '5차 정기 회의',
                description: '스터디 관리 사프',
              ),
              ScheduleModel(
                id: 2,
                startAt: DateTime(2024, 2, 22, 17),
                endAt: DateTime(2024, 2, 22, 19),
                title: '포트폴리오 번개 리뷰',
                description: 'UX 디자인 스터디',
              ),
            ],
          ),
          ScheduleGroupModel(
            id: 2,
            date: DateTime(2024, 2, 24),
            schedules: [
              ScheduleModel(
                id: 1,
                startAt: DateTime(2024, 2, 24, 14),
                endAt: DateTime(2024, 2, 24, 16),
                title: '디자인 QA',
                description: '스터디 관리 사프',
              ),
              ScheduleModel(
                id: 2,
                startAt: DateTime(2024, 2, 24, 19),
                endAt: DateTime(2024, 2, 24, 22),
                title: '모여서 각자 블렌더',
                description: 'Blender 공부방',
              ),
            ],
          ),
          ScheduleGroupModel(
            id: 3,
            date: DateTime(2024, 2, 25),
            schedules: [
              ScheduleModel(
                id: 1,
                startAt: DateTime(2024, 2, 25, 13),
                endAt: DateTime(2024, 2, 25, 15),
                title: '망원동 당인리 책 발전소',
                description: '마포 독서모임',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
