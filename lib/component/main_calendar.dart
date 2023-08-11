import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TableCalendar(
        locale: 'ko_kr',
        headerVisible: false,
        onDaySelected: onDaySelected,
        selectedDayPredicate: (date) =>
            date.year == selectedDate.year && date.month == selectedDate.month && date.day == selectedDate.day,
        focusedDay: DateTime.now(),
        firstDay: DateTime(1900, 1, 1),
        lastDay: DateTime(2300, 1, 1),
        calendarFormat: CalendarFormat.week,
        calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          defaultTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          weekendTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[500],
            borderRadius: BorderRadius.circular(8),
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
          // BoxDecoration(
          //   borderRadius: BorderRadius.circular(8),
          //   color: Colors.blue[600],
          // ),
          selectedTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          markerSize: 3,
          markersAlignment: Alignment.bottomCenter,
          markerDecoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
