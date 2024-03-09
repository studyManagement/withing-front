import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeStudyNotificaticator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = context.select<StudyListViewModel, DateTime>(
        (provider) => provider.selectedDate);
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.selectStudyListView);

    return ListView.separated(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        StudyListView study = studies[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오전 9:00 ~ 오전 11:00',
              style: const TextStyle(
                color: AppColors.gray600,
                fontWeight: AppFonts.fontWeight500,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              study.studyName,
              style: const TextStyle(
                color: AppColors.gray800,
                fontWeight: AppFonts.fontWeight600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              study.studyName,
              style: TextStyle(
                color: AppColors.gray400,
                fontWeight: AppFonts.fontWeight600,
                fontSize: 14,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            thickness: 1,
            color: AppColors.gray100,
          ),
        );
      },
      itemCount: studies.length,
    );
  }
}
