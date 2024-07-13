import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/button/value_button.dart';
import 'package:modi/common/components/spinner/dateTime/date_time_spinner.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class DateTimeRangeSelector extends StatefulWidget {
  final DateTime startAt;
  final DateTime endAt;
  final Function(DateTime, DateTime) onChange;

  const DateTimeRangeSelector({
    required this.startAt,
    required this.endAt,
    required this.onChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DateTimeRangeSelectorState();
}

class _DateTimeRangeSelectorState extends State<DateTimeRangeSelector> {
  late DateTime _startAt;
  late DateTime _endAt;
  bool isInit = true;

  @override
  void initState() {
    super.initState();
    _startAt = widget.startAt;
    _endAt = widget.endAt;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _makeScheduleSelector(
            context,
            title: '시작일',
            isStartAt: true,
            startAt: _startAt,
            endAt: _endAt,
            onTap: (DateTime startAt, DateTime endAt) {
              setState(() {
                _startAt = startAt;
                _endAt = endAt;
              });
              widget.onChange(_startAt, _endAt);
            },
          ),
          const SizedBox(height: 12),
          _makeScheduleSelector(
            context,
            title: '종료일',
            isStartAt: false,
            startAt: _startAt,
            endAt: _endAt,
            onTap: (DateTime startAt, DateTime endAt) {
              setState(() {
                _startAt = startAt;
                _endAt = endAt;
              });
              widget.onChange(_startAt, _endAt);
            },
          ),
        ],
      ),
    );
  }

  GestureDetector _makeScheduleSelector(
    BuildContext context, {
    required String title,
    required bool isStartAt,
    required DateTime startAt,
    required DateTime endAt,
    required Function(DateTime, DateTime) onTap,
  }) {
    final dateTimeFormatter = DateFormat('MM. dd (E) a hh:mm', 'ko');
    int selectItem = isStartAt ? 1 : 2;
    DateTime currentDateTime = isStartAt ? startAt : endAt;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => ModiModal.openBottomSheet(
        context,
        widget: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        '기간 선택',
                        style: TextStyle(
                          color: AppColors.gray800,
                          fontWeight: AppFonts.fontWeight600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '일정으로 등록할 기간을 선택해주세요.',
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
                        dateTimeFormatter.format(startAt),
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
                        dateTimeFormatter.format(endAt),
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
                      DateTimeSpinner(currentDateTime, (DateTime dateTime) {
                          setState(() {
                            if (selectItem == 1) {
                              startAt = dateTime;
                            } else {
                              endAt = dateTime;
                            }
                          });
                      }),
                      const SizedBox(height: 40),
                      ConfirmButton(
                        onTap: () {
                          onTap(startAt, endAt);
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.gray500)),
          const SizedBox(width: 12),
          Expanded(
            child: ValueButton(dateTimeFormatter.format(currentDateTime)),
          ),
        ],
      ),
    );
  }
}
