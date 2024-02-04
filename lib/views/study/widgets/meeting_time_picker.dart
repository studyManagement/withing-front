import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/theme/app/app_colors.dart';

class MeetingTimePicker extends StatefulWidget {
  final String start;
  final String end;
  final bool isInit;
  final Function? notifyParent;

  const MeetingTimePicker({super.key, required this.start, required this.end,required this.isInit,required this.notifyParent});

  @override
  State<MeetingTimePicker> createState() => _MeetingTimePickerState();
}

class _MeetingTimePickerState extends State<MeetingTimePicker> {
  String start = '', end = '';


  @override
  Widget build(BuildContext context) {
    if(widget.isInit){
      start='';
      end='';
    }

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
                        child: Text((start == '') ? '미등록' : start,
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
                        child: Text((end == '') ? '미등록' : end,
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

        setState(() {
          if (flag == 0) {
            start = selectedString + time.toString();
          } else {
            end = selectedString + time.toString();
          }
          widget.notifyParent!(start,end);
        });
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
