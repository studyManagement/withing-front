import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:modi/service/study/MeetingType.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';

class MeetingTimePicker extends StatelessWidget {
  final MeetingType type;
  const MeetingTimePicker({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StudyViewModel>();
    return Column(
      children: [
        const SizedBox(height: 24),
        const Divider(
          thickness: 6,
          color: AppColors.gray50,
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('진행 시간',
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
                      showBottomPicker(context,true,viewModel,type);
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
                        child: Text(viewModel.startTime,
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
                      showBottomPicker(context,false,viewModel,type);
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
                        child: Text(viewModel.endTime,
                            style: Theme.of(context).textTheme.bodySmall)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showBottomPicker(BuildContext context, bool isStart, StudyViewModel viewModel,MeetingType type) {
    BottomPicker.time(
      onSubmit: (time) {
        viewModel.setMeetingTime(isStart, time,type);
        print(viewModel.meetingType);
      },
      dismissable: true,
      height: 496,
      title: (isStart) ? '시작 시간' : '종료 시간',
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
