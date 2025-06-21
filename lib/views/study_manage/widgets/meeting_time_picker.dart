import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/service/study/MeetingType.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/confirm_button.dart';
import '../../../common/components/button/value_button.dart';
import '../../../common/components/spinner/datetime/time_spinner.dart';
import '../../../common/modal/modi_modal.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../common/theme/app/app_fonts.dart';
import '../../schedule/study/study_schedule_add_screen.dart';

class MeetingTimePicker extends StatefulWidget {
  final MeetingType type;
  final DateTime startAt;
  final DateTime endAt;
  final Function(DateTime, DateTime) onChange;

  const MeetingTimePicker({
    super.key,
    required this.type,
    required this.startAt,
    required this.endAt,
    required this.onChange,
  });

  @override
  State<MeetingTimePicker> createState() => _MeetingTimePickerState();
}

class _MeetingTimePickerState extends State<MeetingTimePicker> {
  late DateTime _startAt;
  late DateTime _endAt;
  late int selectItem;
  final dateTimeFormatter = DateFormat('a hh:mm', 'ko');

  @override
  void initState() {
    super.initState();
    _startAt = widget.startAt;
    _endAt = widget.endAt;
    selectItem = 1;
  }

  void _updateDateTime(DateTime dateTime) {
    setState(() {
      if (selectItem == 1) {
        _startAt = dateTime;
      } else {
        _endAt = dateTime;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StudyViewModel>();
    final List<int> selectedDays = viewModel.selectedDays;

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
              InkWell(
                onTap: () {
                  selectItem =1;
                  viewModel.meetingType = widget.type;
                  viewModel.selectedDays = selectedDays;
                  ModiModal.openBottomSheet(
                    context,
                    widget: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 40, left: 16, right: 16, bottom: 20),
                            child: Column(
                              children: [
                                Text(
                                  '시간 선택',
                                  style: TextStyle(
                                    color: AppColors.gray800,
                                    fontWeight: AppFonts.fontWeight600,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '정기 모임 시간을 설정해주세요.',
                                  style: TextStyle(
                                    color: AppColors.gray400,
                                    fontSize: 14,
                                    fontWeight: AppFonts.fontWeight500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: AppColors.gray50,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ValueButton(dateTimeFormatter.format(_startAt),
                                    textAlign: TextAlign.center, onTap: () {
                                  viewModel.meetingType = widget.type;
                                  setState(() {
                                    selectItem = 1;
                                  });
                                },
                                  borderColor: selectItem == 1
                                      ? AppColors.blue400
                                      : AppColors.gray150,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text(
                                    '-',
                                    style: TextStyle(color: AppColors.gray200),
                                  ),
                                ),
                                ValueButton(
                                  dateTimeFormatter.format(_endAt),
                                  textAlign: TextAlign.center,
                                  onTap: () {
                                    viewModel.meetingType = widget.type;
                                    setState(() {
                                      selectItem = 2;
                                    });
                                  },
                                  borderColor: selectItem == 2
                                      ? AppColors.blue400
                                      : AppColors.gray150,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                TimeSpinner(
                                  standard: (selectItem==1) ? _startAt:_endAt,
                                  onChanged: (DateTime dateTime) {
                                    setState(() {
                                      _updateDateTime(dateTime);
                                     viewModel.meetingType = widget.type;
                                      widget.onChange(_startAt,_endAt);
                                    });
                                  },
                                  selectItem: selectItem,
                                  focusedBoxWidth: 244,
                                ),
                                const SizedBox(height: 40),
                                ConfirmButton(
                                  onTap:()=>context.pop(),
                                  text: '선택 완료',
                                  backgroundColor:AppColors.blue600,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    height: 496,
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('시작',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.gray500)),
                        const SizedBox(width: 12),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            width: 324,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: AppColors.gray150),
                            ),
                            child: Text(dateTimeFormatter.format(_startAt),
                                style: Theme.of(context).textTheme.bodySmall)),
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
                        Container(
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
                            child: Text(dateTimeFormatter.format(_endAt),
                                style: Theme.of(context).textTheme.bodySmall)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
