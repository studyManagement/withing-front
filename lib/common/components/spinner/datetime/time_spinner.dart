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
  final double? focusedBoxWidth;

  const TimeSpinner(this.standard, this.onChanged, {super.key, this.focusedBoxWidth});
}

class _TimeSpinnerState extends State<TimeSpinner> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    DateTimeGenerator hourGenerator = HourGenerator();
    DateTimeGenerator minuteGenerator = MinuteGenerator();
    DateTimeCalculator dateTimeCalculator = DateTimeCalculator(widget.onChanged, widget.standard);

    return Stack(
      children: [
        Positioned(
          top: 54,
          child: Container(
            alignment: Alignment.center,
            width: widget.focusedBoxWidth ?? MediaQuery.of(context).size.width - 32,
            height: 37,
            decoration: BoxDecoration(
              color: AppColors.blue100,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        SizedBox(
          width: widget.focusedBoxWidth ?? double.infinity,
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
                  initialValue: (widget.standard.hour > 11) ? '오후' : '오전',
                  onChanged: (index, value) =>
                      dateTimeCalculator.setPart(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
                  width: 60,
                  height: 160,
                  children: hourGenerator.makeElements(widget.standard),
                  initialValue: (widget.standard.hour == 0) ? (widget.standard.hour + 12).toString() : (widget.standard.hour > 12)
                      ? (widget.standard.hour - 12).toString()
                      : widget.standard.hour.toString(),
                  onChanged: (index, value) =>
                      dateTimeCalculator.setHour(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: Spinner(
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
                  width: 60,
                  height: 160,
                  children: minuteGenerator.makeElements(widget.standard),
                  initialValue: widget.standard.minute.toString(),
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
