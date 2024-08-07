import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../modal/modi_modal.dart';
import '../../theme/app/app_colors.dart';
import '../../theme/app/app_fonts.dart';
import '../button/confirm_button.dart';
import '../button/value_button.dart';
import '../calendar/calendar.dart';

class DateRangeSelector extends StatefulWidget {
  const DateRangeSelector({
    super.key,
    this.initialDates = const [],
    required this.onChange,
  });

  final List<DateTime> initialDates;
  final Function(List<DateTime>) onChange;

  @override
  State<StatefulWidget> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  late List<DateTime> selectedDates;
  late DateTime? startAt;
  late DateTime? endAt;

  void _makeModal() {
    ModiModal.openBottomSheet(
      context,
      widget: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            child: Column(
              children: [
                Text(
                  '날짜 선택',
                  style: TextStyle(
                    color: AppColors.gray800,
                    fontWeight: AppFonts.fontWeight600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '일정 투표를 받고 싶은 날짜를 선택해주세요. (최대 7일)',
                  style: TextStyle(
                    color: AppColors.gray400,
                    fontSize: 14,
                    fontWeight: AppFonts.fontWeight500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: AppColors.gray150,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Calendar(
                  onDaySelected: (
                    DateTime? rangeStart,
                    DateTime? rangeEnd,
                  ) =>
                      onSelectDate(rangeStart, rangeEnd),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConfirmButton(
              onTap: () => setDates(context),
              text: '선택 완료',
              backgroundColor: AppColors.blue600,
              height: 50,
              width: MediaQuery.of(context).size.width - 32,
            ),
          ),
        ],
      ),
      height: 554,
    );
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedDates = (widget.initialDates.isEmpty) ? [now] : widget.initialDates;
    startAt = now;
    endAt = now;
  }

  bool isSevenDays(DateTime startAt, DateTime endAt) {
    return endAt.difference(startAt).inDays.abs() <= 7;
  }

  void deleteDate(int index) {
    setState(() {
      selectedDates.removeAt(index);
      widget.onChange(selectedDates);
    });
  }

  List<DateTime> getDatesBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> dates = [];

    for (var i = 0; i <= endDate.difference(startDate).inDays; i++) {
      dates.add(startDate.add(Duration(days: i)));
    }

    return dates;
  }

  void setDates(BuildContext context) {
    log('startAt: $startAt, endAt: $endAt');

    if (startAt == null && endAt == null) {
      ModiModal.openDialog(
        context,
        '문제가 발생했어요',
        '날짜를 선택해 주세요.',
        false,
        () => null,
        () => null,
      );
      return;
    }

    if (startAt != null && endAt == null) {
      context.pop();
      setState(() {
        selectedDates = [startAt!];
      });
      widget.onChange(selectedDates);
      return;
    }

    if (!isSevenDays(startAt!, endAt!)) {
      ModiModal.openDialog(
        context,
        '문제가 발생했어요',
        '투표 기간은 최대 7일 이내로만 설정할 수 있어요.',
        false,
        () => null,
        () => null,
      );
      return;
    }

    List<DateTime> dates = getDatesBetween(startAt!, endAt!);
    setState(() {
      context.pop();
      selectedDates = dates;
    });
    widget.onChange(selectedDates);
  }

  void onSelectDate(DateTime? a, DateTime? b) {
    log('onSelectDate: startAt: $a, endAt: $b');

    startAt = a;
    endAt = b;
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeFormatter = DateFormat('yyyy. MM. dd (E)', 'ko');

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Widget? deleteButton = index != 0
            ? GestureDetector(
                onTap: () => deleteDate(index),
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red400,
                  ),
                  child: Image.asset('asset/delete.png'),
                ),
              )
            : null;

        DateTime selectedDate = selectedDates[index];

        return Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray100,
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: AppColors.gray400,
                    fontSize: 12,
                    fontWeight: AppFonts.fontWeight500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ValueButton(
              dateTimeFormatter.format(selectedDate),
              rightWidget: deleteButton,
              onTap: () {
                _makeModal();
              },
            ),
          ],
        );
      },
      itemCount: selectedDates.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
