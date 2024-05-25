import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/checkbox/checkbox_state.dart';
import 'package:modi/common/components/checkbox/icon_checkbox.dart';
import 'package:modi/common/components/table/schedule/schedule_table_vote_status.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/di/injection.dart';

import '../../../theme/app/app_colors.dart';
import '../../../theme/app/app_fonts.dart';
import '../../image/circle_image.dart';

class ScheduleTable extends StatelessWidget {
  const ScheduleTable({
    required this.dateTimes,
    required this.startAt,
    required this.endAt,
    required this.voteStatus,
    required this.maxVoteCount,
    required this.readOnly,
    this.onClick,
    super.key,
  });

  final List<DateTime> dateTimes;
  final TimeOfDay startAt;
  final TimeOfDay endAt;
  final Map<int, List<ScheduleTableVoteStatus>> voteStatus;
  final int maxVoteCount;
  final ValueChanged<CheckBoxState>? onClick;
  final bool readOnly;

  List<TimeOfDay> getTimeRangeWithoutMinutes(
      TimeOfDay startTime, TimeOfDay endTime) {
    List<TimeOfDay> timeRangeList = [];

    int startHour = startTime.hour;
    int endHour = endTime.hour;

    for (int hour = startHour; hour <= endHour; hour++) {
      timeRangeList.add(TimeOfDay(hour: hour, minute: 0));
    }

    return timeRangeList;
  }

  Color _getBackgroundColorByRatio(double ratio) {
    if (ratio == 0) {
      return AppColors.white;
    } else if (ratio >= 0.75) {
      return AppColors.blue400;
    } else if (ratio >= 0.5) {
      return AppColors.blue300;
    } else if (ratio >= 0.25) {
      return AppColors.blue200;
    } else if (ratio >= 0.1) {
      return AppColors.blue100;
    } else {
      return AppColors.blue500;
    }
  }

  Color _getColorByRatio(double ratio) {
    return (ratio > 0) ? AppColors.white : AppColors.gray200;
  }

  Row _makeProfile(String nickname, String? profileImage) {
    return Row(
      children: [
        CircleImage(
          22,
          22,
          image: Image.asset('asset/default_image.png'),
        ),
        const SizedBox(width: 6),
        Text(
          nickname,
          style: const TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  List<TableCell> _makeTableHeader() {
    final weekDayFormat = DateFormat('E', 'ko');
    final dateFormat = DateFormat('M/d', 'ko');

    return dateTimes
        .map(
          (dateTime) => TableCell(
            child: Column(
              children: [
                Text(
                  weekDayFormat.format(dateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: AppFonts.fontWeight500,
                    color: AppColors.gray400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateFormat.format(dateTime),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: AppFonts.fontWeight500,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        )
        .toList();
  }

  List<TableRow> _makeTableRow() {
    final LoggingInterface logger = getIt<LoggingInterface>();
    return getTimeRangeWithoutMinutes(startAt, endAt)
        .map(
          (time) => TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  alignment: Alignment.topRight,
                  child: Text(
                    '${time.hour}:00',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: AppFonts.fontWeight500,
                      color: AppColors.gray500,
                    ),
                  ),
                ),
              ),
              ...dateTimes.asMap().entries.map(
                (entry) {
                  int index = entry.key;
                  List<ScheduleTableVoteStatus> statuses = voteStatus[index]
                          ?.where((e) => e.selectedTime.hour == time.hour)
                          .toList() ??
                      [];
                  double ratio = statuses.length / maxVoteCount;
                  return TableCell(
                    child: PopupMenuButton(
                      offset: const Offset(0, 50),
                      tooltip: '',
                      color: AppColors.white,
                      surfaceTintColor: AppColors.white,
                      itemBuilder: (BuildContext context) {
                        return readOnly
                            ? [
                                PopupMenuItem(
                                  enabled: false,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${statuses.length}명 투표',
                                        style: const TextStyle(
                                          color: AppColors.blue400,
                                          fontSize: 12,
                                          fontWeight: AppFonts.fontWeight600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        height: 100,
                                        width: 120,
                                        child: ListView.builder(
                                          itemExtent: 30,
                                          itemBuilder: (context, index) {
                                            ScheduleTableVoteStatus status =
                                                statuses[index];

                                            return _makeProfile(
                                              status.nickname,
                                              null,
                                            );
                                          },
                                          itemCount: statuses.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            : [];
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getBackgroundColorByRatio(ratio),
                          border: Border.all(color: AppColors.gray50),
                        ),
                        child: readOnly
                            ? _makeElementIcon(time.hour, ratio)
                            : IconCheckBox<DateTime>(
                                notCheckedBackgroundColor: Colors.transparent,
                                checkedBackgroundColor: AppColors.blue400,
                                checkedColor: AppColors.white,
                                notCheckedColor: AppColors.gray200,
                                icon: _makeIconData(time.hour),
                                size: 20,
                                value: DateTime(
                                  entry.value.year,
                                  entry.value.month,
                                  entry.value.day,
                                  time.hour,
                                  0,
                                ),
                                onChange: (state) =>
                                    {if (onClick != null) onClick!(state)}),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
        .toList();
  }

  IconData _makeIconData(int hour) {
    return (hour >= 6 && hour <= 18) ? Icons.sunny : FontAwesomeIcons.solidMoon;
  }

  Icon _makeElementIcon(int hour, double ratio) {
    return Icon(
      _makeIconData(hour),
      size: 20,
      color: _getColorByRatio(ratio),
    );
  }

  @override
  Widget build(BuildContext context) {
    dateTimes.sort((a, b) => a.compareTo(b));

    List<TableCell> headers = _makeTableHeader();
    List<TableRow> rows = _makeTableRow();

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {0: FractionColumnWidth(.11)},
      children: [
        TableRow(
          children: [const TableCell(child: SizedBox()), ...headers],
        ),
        ...rows,
      ],
    );
  }
}
