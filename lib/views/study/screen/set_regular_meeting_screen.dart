import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/study_bottom_button.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/views/study/screen/study_manage_screen.dart';
import 'package:modi/views/study/widgets/meeting_days_selector.dart';

import '../../../service/study/MeetingType.dart';

import '../../../view_models/study/study_viewmodel.dart';
import '../widgets/meeting_time_picker.dart';

class SetRegularMeetingScreen extends StatefulWidget {
  final StudyViewModel viewModel;

  const SetRegularMeetingScreen({super.key, required this.viewModel});

  @override
  State<SetRegularMeetingScreen> createState() =>
      _SetRegularMeetingScreenState();
}

class _SetRegularMeetingScreenState extends State<SetRegularMeetingScreen> {
  List<int> days = [];
  String start = '', end = '';
  DateTime? selected;
  List<String> weekDays = ["월", "화", "수", "목", "금", "토", "일"];
  MeetingType type = MeetingType.NONE;
  MeetingTimePicker? timePicker;
  bool isInit = false;

  void updateTime(String startTime, String endTime) {
    setState(() {
      isInit = false;
      start = startTime;
      end = endTime;
    });
  }

  @override
  void initState() {
    super.initState();
    //  type = widget.viewModel.meeting_type;
    //  days = widget.viewModel.days;
    //  start = widget.viewModel.meetingModel[0].startTime;
    //  end = widget.viewModel.meetingModel[0].endTime;
    type = MeetingType.NONE;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: initAppBar(),
      body: SafeArea(
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
                  radioButton(MeetingType.DAILY, '매일'),
                  const SizedBox(width: 20),
                  radioButton(MeetingType.WEEKLY, '매주'),
                  const SizedBox(width: 20),
                  radioButton(MeetingType.NONE, '설정안함'),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            meetingType(type),
            const Spacer(),
            Center(
                child: StudyBottomButton(
                    onTap: () {
                      print("정기모임 설정 완료");
                      print(type);
                      for (int i in days) {
                        print("${weekDays[i]} ");
                      }
                      print("시작 시간: $start");
                      print("종료 시간: $end");
                    },
                    text: '설정 완료'))
          ],
        ),
      ),
    );
  }

  AppBar initAppBar() {
    return AppBar(
      title: Text('정기모임', style: Theme.of(context).textTheme.titleMedium),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => {context.pop()},
      ),
      centerTitle: true,
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.white,
      elevation: 0,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (type != MeetingType.NONE) {
              setState(() {
                days = [];
                isInit = true;
              });
            }
          },
          child: Text("초기화",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: (type != MeetingType.NONE)
                      ? AppColors.blue400
                      : AppColors.gray300,
                  fontSize: 16)),
        )
      ],
    );
  }

  Widget radioButton(MeetingType valueType, String title) {
    return Row(
      children: [
        Radio(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.blue400;
              }
              return null;
            }),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity:
                const VisualDensity(horizontal: VisualDensity.minimumDensity),
            value: valueType,
            groupValue: type,
            onChanged: (value) {
              setState(() {
                type = value!;
              });
            }),
        const SizedBox(width: 10),
        Text(title, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }

  Widget meetingType(MeetingType type) {
    if(isInit){
      start = '';
      end = '';
    }
    switch (type) {
      case MeetingType.DAILY:
        return MeetingTimePicker(
            start: start, end: end, notifyParent: updateTime, isInit: isInit);
      case MeetingType.WEEKLY:
        return Column(
          children: [
            MeetingDaysSelector(days: days),
            MeetingTimePicker(
                start: start,
                end: end,
                notifyParent: updateTime,
                isInit: isInit)
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
