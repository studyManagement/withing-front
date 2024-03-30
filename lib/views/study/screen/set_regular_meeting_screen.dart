import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/study_bottom_button.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/views/study/widgets/meeting_days_selector.dart';
import 'package:provider/provider.dart';
import '../../../service/study/MeetingType.dart';
import '../../../view_models/study/study_viewmodel.dart';
import '../widgets/meeting_time_picker.dart';

class SetRegularMeetingScreen extends StatelessWidget {
  final StudyViewModel viewModel;

  const SetRegularMeetingScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    viewModel.getSelectedDaysAndTime();
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<StudyViewModel>(builder: (context, consumer, child) {
          MeetingType curType = consumer.meetingType;
          return DefaultLayout(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: StudyBottomButton(
                color: (consumer.checkDaysAndTimes(curType))
                    ? null
                    : AppColors.gray400,
                onTap: (consumer.checkDaysAndTimes(curType))
                    ? () {
                        consumer.setMeetingSchedule(curType);
                        context.go('/studies/${viewModel.study!.id}');
                      }
                    : null,
                text: '설정 완료'),
            title: '정기모임',
            leader: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => {context.pop()},
            ),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: (consumer.meetingType == MeetingType.NONE)
                    ? null
                    : () {
                        // 매일, 매주인 경우만 활성화
                        consumer.initDaysAndTime(curType);
                      },
                child: Text("초기화",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: (consumer.meetingType != MeetingType.NONE)
                            ? AppColors.blue400
                            : AppColors.gray300,
                        fontSize: 16)),
              )
            ],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('모임 간격',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.gray500)),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const CustomRadioButton(type: MeetingType.DAILY),
                            const SizedBox(width: 10),
                            Text('매일',
                                style:
                                    Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const CustomRadioButton(type: MeetingType.WEEKLY),
                            const SizedBox(width: 10),
                            Text('매주',
                                style:
                                    Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const CustomRadioButton(type: MeetingType.NONE),
                            const SizedBox(width: 10),
                            Text('설정안함',
                                style:
                                    Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                        //  const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  if (consumer.meetingType == MeetingType.NONE)
                    const SizedBox()
                  else if (consumer.meetingType == MeetingType.WEEKLY)
                    MeetingDaysSelector(
                      type: curType,
                    ),
                  if (consumer.meetingType != MeetingType.NONE)
                    MeetingTimePicker(
                      type: curType,
                    ),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          );
        }));
  }
}

class CustomRadioButton extends StatelessWidget {
  final MeetingType type;

  const CustomRadioButton({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StudyViewModel>();
    return Radio(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.blue400;
          }
          return null;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity:
            const VisualDensity(horizontal: VisualDensity.minimumDensity),
        value: type,
        groupValue: viewModel.meetingType,
        onChanged: (value) {
          viewModel.initMeetingSchedule(value!);
        });
  }
}
