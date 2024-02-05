import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/views/study/widgets/study_main_appbar.dart';
import 'package:modi/views/study/widgets/study_main_buttons.dart';
import 'package:provider/provider.dart';
import '../../di/injection.dart';
import 'widgets/study_details.dart';
import 'widgets/study_notices.dart';
import 'widgets/study_header.dart';

class MyStudyInfoScreen extends StatelessWidget {
  final int studyId;

  const MyStudyInfoScreen({
    super.key,
    required this.studyId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudyViewModel(getIt<StudyService>()),
      child: Consumer<StudyViewModel>(builder: (context, data, child) {
        data.fetchStudyInfo(context, studyId);
        if (data.study == null) return SizedBox();
        return Scaffold(
          appBar: StudyMainAppBar(studyId: studyId,leaderId: data.study.leaderId),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),
                const SizedBox(height: 16),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      data.study.explanation,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: AppColors.gray100,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 16),
                    StudyMainButtons(
                      onTap: () {},
                      title: "Schedule",
                      subtitle: "일정",
                      image: Image.asset('asset/schedule.png'),
                    ),
                    const SizedBox(width: 9),
                    StudyMainButtons(
                        onTap: () {
                          context.push('/studies/$studyId/boards');
                        },
                        title: "Community",
                        subtitle: "게시판",
                        image: Image.asset('asset/community.png')),
                    const SizedBox(width: 16),
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: StudyDetails(),
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 6,
                  color: AppColors.gray100,
                ),
                const SizedBox(height: 10),
                Notice(studyId: studyId),
              ],
            ),
          ),
        );
      }),
    );
  }
}
