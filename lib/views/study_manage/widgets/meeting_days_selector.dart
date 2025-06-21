import 'package:flutter/material.dart';
import 'package:modi/service/study/MeetingType.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/study_viewmodel.dart';

class MeetingDaysSelector extends StatelessWidget {
 final MeetingType type;
  MeetingDaysSelector({
    super.key,
    required this.type
  });

  List<String> weekDays = ["월", "화", "수", "목", "금", "토", "일"];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StudyViewModel>();
   // MeetingType curType = viewModel.meetingType;
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
              for (int i = 1; i <= weekDays.length; i++) // 선택한 아이템 인덱스
                GestureDetector(
                  onTap: () {
                   viewModel.setMeetingDays(i, type);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: ShapeDecoration(
                      color: (viewModel.selectedDays.contains(i))
                          ? AppColors.blue600
                          : AppColors.gray100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Center(
                      child: Text(
                        weekDays[i-1],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: (viewModel.selectedDays.contains(i))
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
