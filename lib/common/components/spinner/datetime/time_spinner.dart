import 'package:flutter/cupertino.dart';
import 'package:modi/common/components/spinner/datetime/date_time_calculator.dart';
import 'package:modi/common/components/spinner/datetime/generator/date_time_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/hour_generator.dart';
import 'package:modi/common/components/spinner/datetime/generator/minute_generator.dart';
import 'package:modi/common/components/spinner/spinner.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class TimeSpinner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeSpinnerState();

  final DateTime standard;
  final Function(DateTime) onChanged;

  const TimeSpinner(this.standard, this.onChanged, {super.key});
}

class _TimeSpinnerState extends State<TimeSpinner> {
  late DateTimeCalculator dateTimeCalculator;
  late DateTime standard;

  @override
  void initState() {
    super.initState();
    standard = widget.standard;
    dateTimeCalculator = DateTimeCalculator(widget.onChanged, standard);
  }

  @override
  Widget build(BuildContext context) {
    DateTimeGenerator hourGenerator = HourGenerator();
    DateTimeGenerator minuteGenerator = MinuteGenerator();

    return Stack(
      children: [
        Positioned(
          top: 54,
          child: Container(
            width: MediaQuery.of(context).size.width - 30,
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
                  initialValue: (standard.hour == 0) ? (standard.hour + 12).toString() : (standard.hour > 12)
                      ? (standard.hour - 12).toString()
                      : standard.hour.toString(),
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
                  initialValue: standard.minute.toString(),
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
