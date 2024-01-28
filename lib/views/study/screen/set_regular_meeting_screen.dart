import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:withing/common/components/study_bottom_button.dart';

import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/views/study/widgets/regular_meeting_selector.dart';
import 'package:bottom_picker/bottom_picker.dart';

class SetRegularMeetingScreen extends StatefulWidget {
  // 정기모임 설정 여부 확인 필요
  const SetRegularMeetingScreen({super.key});

  @override
  State<SetRegularMeetingScreen> createState() =>
      _SetRegularMeetingScreenState();
}

class _SetRegularMeetingScreenState extends State<SetRegularMeetingScreen> {
  int? gap, selectedIdx;
  List<String> days = [];
  String start = '미등록', end = '미등록';
  DateTime? selected;
  List<String> weekDays = ["월", "화", "수", "목", "금", "토", "일"];

  @override
  void initState() {
    super.initState();
    gap = -1;
    selectedIdx = -1;
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
                              isSelected:
                                  (days.contains(weekDays[i])) ? true : false
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
                  const SizedBox(width: 12),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showBottomPicker(context, 0);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        width: 324,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: AppColors.gray150),
                        ),
                        child: Text(start,
                            style: Theme.of(context).textTheme.bodySmall)),
                  ),
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
                  const SizedBox(width: 12),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showBottomPicker(context, 1);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        width: 324,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            color: AppColors.gray150,
                          ),
                        ),
                        child: Text(end,
                            style: Theme.of(context).textTheme.bodySmall)),
                  ),
                ],
              ),
              const Spacer(),
              Center(child: StudyBottomButton(onTap: () {}, text: '설정 완료'))
            ],
          ),
        ));
  }

  void showBottomPicker(BuildContext context, int flag) {
    String selectedString = '';
    BottomPicker.time(
      onSubmit: (time) {
        if (time.hour < 12) {
          selectedString = '오전';
        } else {
          selectedString = '오후';
        }
        time = DateFormat(" hh:mm").format(time);
        if (flag == 0) {
          start = selectedString + time.toString();
        } else {
          end = selectedString + time.toString();
        }
        setState(() {});
      },
      dismissable: true,
      height: 496,
      title: (flag == 0) ? '시작 시간' : '종료 시간',
      titleStyle: Theme.of(context).textTheme.titleMedium!,
      titlePadding: const EdgeInsets.only(top: 40, bottom: 8),
      displayCloseIcon: false,
      titleAlignment: CrossAxisAlignment.center,
      description: '정기 모임 시간을 설정해주세요.',
      descriptionStyle: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: AppColors.gray400),
      use24hFormat: false,
      initialTime: Time(minutes: 23, hours: 12),
      buttonWidth: 330,
      buttonText: '설정 완료',
      buttonTextStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: AppColors.white),
      displayButtonIcon: false,
      buttonSingleColor: AppColors.blue600,
    ).show(context);
  }
}
