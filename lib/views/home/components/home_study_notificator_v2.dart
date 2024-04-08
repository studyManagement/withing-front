import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeStudyNotificator extends StatelessWidget {
  const HomeStudyNotificator(this.selectedDate, {super.key});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.selectStudyListView);

    return studies.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: HomeStudyNotificatorList(selectedDate, studies),
          )
        : Container(
            decoration: const BoxDecoration(color: AppColors.gray50),
            height: 88,
            width: MediaQuery.of(context).size.width,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '등록된 일정이 없어요',
                  style: TextStyle(
                    color: AppColors.gray300,
                    fontWeight: AppFonts.fontWeight500,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          );
  }
}

class HomeStudyNotificatorList extends StatelessWidget {
  const HomeStudyNotificatorList(this.selectedDate, this.studies, {super.key});

  final DateTime selectedDate;
  final List<StudyListView> studies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        StudyListView study = studies[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              style: const TextStyle(
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
