import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  const MainCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(1900, 1, 1),
      lastDay: DateTime(2300, 1, 1),
    );
  }
}
