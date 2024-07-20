import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/button/value_button.dart';
import 'package:modi/common/components/spinner/datetime/time_spinner.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class TimeRangeSelector extends StatefulWidget {
  final DateTime startAt;
  final DateTime endAt;
  final Function(DateTime, DateTime) onChange;

  const TimeRangeSelector({
    required this.startAt,
    required this.endAt,
    required this.onChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
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
    widget.onChange(_startAt,_endAt);
    return InkWell(
      onTap: () {
        selectItem = 1; // always start
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
                          '일정 투표를 받고 싶은 시간대를 선택해주세요.',
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
                        ValueButton(
                          dateTimeFormatter.format(_startAt),
                          borderColor: selectItem == 1
                              ? AppColors.blue400
                              : AppColors.gray150,
                          textAlign: TextAlign.center,
                          onTap: () => {
                            setState(() {
                              selectItem = 1;
                            }),
                          },
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '-',
                          style: TextStyle(color: AppColors.gray200),
                        ),
                        const SizedBox(width: 4),
                        ValueButton(
                          dateTimeFormatter.format(_endAt),
                          borderColor: selectItem == 2
                              ? AppColors.blue400
                              : AppColors.gray150,
                          textAlign: TextAlign.center,
                          onTap: () => {
                            setState(() {
                              selectItem = 2;
                            }),
                          },
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
                          focusedBoxWidth: 244,
                          standard: (selectItem==1)? _startAt:_endAt,
                              onChanged: (DateTime dateTime) {
                            setState(() {
                              _updateDateTime(dateTime);
                              widget.onChange(_startAt,_endAt);
                            });
                          },
                          selectItem: selectItem,
                        ),
                        const SizedBox(height: 40),
                        ConfirmButton(
                          onTap: () {
                            widget.onChange(_startAt, _endAt);
                            Navigator.pop(context);
                          },
                          text: '선택 완료',
                          backgroundColor: AppColors.blue600,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          height: 496,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: AppColors.gray150),
                  ),
                  child: Text(dateTimeFormatter.format(_startAt),
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: AppColors.gray150,
                    ),
                  ),
                  child: Text(dateTimeFormatter.format(_endAt),
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
