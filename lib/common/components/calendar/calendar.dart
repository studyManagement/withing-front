import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({required this.onDaySelected, super.key});
  final Function(
    DateTime? rangeStart,
    DateTime? rangeEnd,
  ) onDaySelected;

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.compareTo(b) == 0;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      widget.onDaySelected(_rangeStart, _rangeEnd);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
    widget.onDaySelected(_rangeStart, _rangeEnd);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 40,
      focusedDay: _focusedDay,
      firstDay: DateTime(2024, 2, 1),
      lastDay: DateTime(2300, 1, 1),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      onDaySelected: _onDaySelected,
      onRangeSelected: _onRangeSelected,
      locale: 'ko_kr',
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: const TextStyle(
          color: AppColors.gray800,
          fontSize: 16,
          fontWeight: AppFonts.fontWeight600,
        ),
        titleTextFormatter: (date, locale) =>
            DateFormat("yyyy. MM").format(_focusedDay),
        headerPadding: const EdgeInsets.only(bottom: 10, left: 0, right: 0),
      ),
      calendarStyle: const CalendarStyle(
        cellPadding: EdgeInsets.all(0),
        defaultTextStyle: TextStyle(
          color: AppColors.gray800,
          fontSize: 14,
          fontWeight: AppFonts.fontWeight500,
        ),
        todayDecoration: BoxDecoration(
            color: AppColors.blue600,
            borderRadius: BorderRadius.all(Radius.circular(36))),
        rangeHighlightScale: 1.0,
        rangeHighlightColor: AppColors.blue100,
        rangeStartDecoration: BoxDecoration(
          color: AppColors.blue400,
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: AppColors.blue400,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
