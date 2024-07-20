import 'package:flutter/cupertino.dart';
import 'package:modi/common/components/spinner/dateTime/date_time_spinner.dart';
import 'package:modi/common/components/spinner/datetime/date_time_calculator.dart';
import 'package:modi/common/components/spinner/datetime/generator/date_time_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/day_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/hour_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/minute_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/month_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/year_generator.dart';
import 'package:modi/common/components/spinner/spinner.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/schedule/schedule_viewmodel.dart';
import '../../../theme/app/app_fonts.dart';

class DateTimeSpinner extends StatefulWidget {
  final DateTime standard;
  final Function(DateTime) onChanged;
  final int selectItem;

  const DateTimeSpinner({super.key, required this.standard, required this.onChanged, required this.selectItem});

  @override
  State<DateTimeSpinner> createState() => _DateTimeSpinnerState();
}


class _DateTimeSpinnerState extends State<DateTimeSpinner> {

  @override
  Widget build(BuildContext context) {

    DateTimeGenerator yearGenerator = YearGenerator();
    DateTimeGenerator monthGenerator = MonthGenerator();
    DateTimeGenerator dayGenerator = DayGenerator();
    DateTimeGenerator hourGenerator = HourGenerator();
    DateTimeGenerator minuteGenerator = MinuteGenerator();

    DateTimeCalculator dateTimeCalculator =
        DateTimeCalculator(widget.onChanged, widget.standard);
    String hour_12 = (widget.standard.hour == 0 || widget.standard.hour == 12)
        ? '12'
        : (widget.standard.hour > 12)
            ? (widget.standard.hour - 12).toString()
            : widget.standard.hour.toString();

    return Stack(
      children: [
        Positioned(
          top: 54,
          child: Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 37,
            decoration: BoxDecoration(
              color: AppColors.blue100,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Spinner(
                  selectItem: widget.selectItem,
                  width: 60,
                  height: 160,
                  children: yearGenerator.makeElements(widget.standard),
                  initialValue: widget.standard.year.toString(),
                  onChanged: (index, value) =>
                      dateTimeCalculator.setYear(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  selectItem: widget.selectItem,
                  width: 60,
                  height: 160,
                  children: monthGenerator.makeElements(widget.standard),
                  initialValue: widget.standard.month.toString(),
                  onChanged: (index, value) =>
                      dateTimeCalculator.setMonth(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  selectItem: widget.selectItem,
                  width: 60,
                  height: 160,
                  children: dayGenerator.makeElements(widget.standard),
                  initialValue: widget.standard.day.toString(),
                  onChanged: (index, value) => dateTimeCalculator.setDay(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  selectItem: widget.selectItem,
                  width: 60,
                  height: 160,
                  children: const ['오전', '오후'],
                  initialValue: (widget.standard.hour > 11) ? '오후' : '오전',
                  onChanged: (index, value) =>
                      dateTimeCalculator.setPart(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  selectItem: widget.selectItem,
                  width: 60,
                  height: 160,
                  children: hourGenerator.makeElements(widget.standard),
                  initialValue: hour_12,
                  onChanged: (index, value) =>
                      dateTimeCalculator.setHour(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  selectItem: widget.selectItem,
                  width: 60,
                  height: 157,
                  children: [':'],
                  initialValue: ':',
                  onChanged: (index, value) {},
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  selectItem: widget.selectItem,
                  width: 60,
                  height: 160,
                  children: minuteGenerator.makeElements(widget.standard),
                  initialValue: widget.standard.minute.toString().padLeft(2, '0'),
                  onChanged: (index, value) =>
                      dateTimeCalculator.setMinute(value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
