import 'package:flutter/cupertino.dart';
import 'package:modi/common/components/spinner/datetime/date_time_calculator.dart';
import 'package:modi/common/components/spinner/datetime/generator/date_time_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/day_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/hour_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/minute_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/month_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/year_generator.dart';
import 'package:modi/common/components/spinner/spinner.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class DateTimeSpinner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DateTimeSpinnerState();

  final DateTime standard;
  final Function(DateTime) onChanged;

  const DateTimeSpinner(this.standard, this.onChanged, {super.key});
}

class _DateTimeSpinnerState extends State<DateTimeSpinner> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    DateTime standard = DateTime.now();
    DateTimeGenerator yearGenerator = YearGenerator();
    DateTimeGenerator monthGenerator = MonthGenerator();
    DateTimeGenerator dayGenerator = DayGenerator();
    DateTimeGenerator hourGenerator = HourGenerator();
    DateTimeGenerator minuteGenerator = MinuteGenerator();

    DateTimeCalculator dateTimeCalculator =
        DateTimeCalculator(widget.onChanged, standard);
    String hour_12 = (standard.hour == 0 || standard.hour == 12)
        ? '12'
        : (standard.hour > 12)
            ? (standard.hour - 12).toString()
            : standard.hour.toString();

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
                flex: 3,
                child: Spinner(
                  width: 60,
                  height: 160,
                  children: yearGenerator.makeElements(standard),
                  initialValue: standard.year.toString(),
                  onChanged: (index, value) =>
                      dateTimeCalculator.setYear(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  width: 40,
                  height: 160,
                  children: monthGenerator.makeElements(standard),
                  initialValue: standard.month.toString(),
                  onChanged: (index, value) =>
                      dateTimeCalculator.setMonth(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  width: 40,
                  height: 160,
                  children: dayGenerator.makeElements(standard),
                  initialValue: standard.day.toString(),
                  onChanged: (index, value) => dateTimeCalculator.setDay(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  width: 60,
                  height: 160,
                  children: const ['오전', '오후'],
                  initialValue: (standard.hour > 11) ? '오후' : '오전',
                  onChanged: (index, value) =>
                      dateTimeCalculator.setPart(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  width: 60,
                  height: 160,
                  children: hourGenerator.makeElements(standard),
                  initialValue: hour_12,
                  onChanged: (index, value) =>
                      dateTimeCalculator.setHour(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  width: 60,
                  height: 160,
                  children: minuteGenerator.makeElements(standard),
                  initialValue: standard.minute.toString().padLeft(2,'0'),
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
