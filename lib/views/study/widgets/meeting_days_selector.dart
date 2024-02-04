import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';

class MeetingDaysSelector extends StatefulWidget {
  final List<int> days;

  const MeetingDaysSelector({
    super.key,
    required this.days,
  });

  @override
  State<MeetingDaysSelector> createState() => _MeetingDaysSelectorState();
}

class _MeetingDaysSelectorState extends State<MeetingDaysSelector> {
  int selectedCnt = 0;
  List<int> selectedDay = [];
  List<String> weekDays = ["월", "화", "수", "목", "금", "토", "일"];

  @override
  Widget build(BuildContext context) {
    selectedDay = widget.days;
    selectedCnt = widget.days.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            color: AppColors.gray50,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (int i = 0; i < weekDays.length; i++) // 선택한 아이템 인덱스
                GestureDetector(
                  onTap: () {
                    if (!selectedDay.contains(i)  && selectedCnt < 3) {
                      setState(() {
                        selectedDay.add(i);
                        selectedCnt++;
                      });
                    } else {
                      setState(() {
                        selectedDay.remove(i);
                        selectedCnt--;
                      });

                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: ShapeDecoration(
                      color: (selectedDay.contains(i))
                          ? AppColors.blue600
                          : AppColors.gray100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Center(
                      child: Text(
                        weekDays[i],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: (selectedDay.contains(i))
                                ? AppColors.white
                                : AppColors.gray500),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
