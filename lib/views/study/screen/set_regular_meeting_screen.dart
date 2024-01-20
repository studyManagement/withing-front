import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/common/modal/withing_modal.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/service/study/study_service.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';
import 'package:withing/views/study/widgets/regular_meeting_selector.dart';
import 'package:withing/views/study/widgets/study_manage_bottomsheet.dart';

import '../../../common/components/study_bottom_button.dart';
import '../../../di/injection.dart';

class SetRegularMeetingScreen extends StatefulWidget {
  // 정기모임 설정 여부 확인 필요
  SetRegularMeetingScreen({super.key});

  int gap = 0;

  @override
  State<SetRegularMeetingScreen> createState() =>
      _SetRegularMeetingScreenState();
}

class _SetRegularMeetingScreenState extends State<SetRegularMeetingScreen> {
  var gap, selectedIdx, days;
  List<String> weekDays = ["월", "화", "수", "목", "금", "토", "일"];

  @override
  void initState() {
    super.initState();
    gap = -1;
    selectedIdx = -1;
    days = []; //월화수
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '정기 모임',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('간격',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.gray500)),
              const SizedBox(height: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIdx != 0) {
                          selectedIdx = 0;
                          gap = 1;
                        } else {
                          selectedIdx = -1;
                          gap = -1;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: ShapeDecoration(
                        color: (selectedIdx == 0)
                            ? AppColors.blue600
                            : AppColors.gray100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        '매일',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: (selectedIdx == 0)
                                  ? AppColors.white
                                  : AppColors.gray500,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIdx != 1) {
                          selectedIdx = 1;
                          gap = 0;
                        } else {
                          selectedIdx = -1;
                          gap = -1;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: ShapeDecoration(
                        color: (selectedIdx == 1)
                            ? AppColors.blue600
                            : AppColors.gray100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        '매주',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: (selectedIdx == 1)
                                ? AppColors.white
                                : AppColors.gray500),
                      ),
                    ),
                  ),
                ],
              ),
              Offstage(
                offstage: (selectedIdx == 0) ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text('요일',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.gray500)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        for (int i = 0; i < weekDays.length; i++)
                          RegularMeetingSelector(
                            itemIdx: i, // 조회한 요일
                            isSelected: (days.contains(weekDays[i])) ? true:false
                          // 최대 카운트 수
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text('스터디 시간',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.gray500)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('시작',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.gray500)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('종료',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.gray500)),
                ],
              ),
            ],
          ),
        ));
  }
}
