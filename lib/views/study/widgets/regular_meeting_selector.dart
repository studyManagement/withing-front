import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';

class RegularMeetingSelector extends StatefulWidget {
  final int itemIdx;
  bool isSelected;// 선택된 아이템 요일 인덱스


  RegularMeetingSelector(
      {super.key,required this.itemIdx, required this.isSelected});

  @override
  State<RegularMeetingSelector> createState() => _RegularMeetingSelectorState();
}

class _RegularMeetingSelectorState extends State<RegularMeetingSelector> {
  int selectedCnt = 0;
  List<String> days = ["월", "화", "수", "목", "금", "토", "일"];


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap:(){
              if(selectedCnt < 4) {
                setState(() {
                  if (widget.isSelected) {
                    widget.isSelected = false;
                    selectedCnt--;
                  }
                  else {
                    widget.isSelected = true;
                    selectedCnt++;
                  }
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(right: 10),
              decoration: ShapeDecoration(
                color: (widget.isSelected) ? AppColors.blue600 : AppColors.gray100 ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: Text(
                days[widget.itemIdx],
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: (widget.isSelected) ? AppColors.white : AppColors.gray500),
              ),
            ),
    );
  }
}
