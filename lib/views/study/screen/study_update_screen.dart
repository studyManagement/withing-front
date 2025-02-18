import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/circular_indicator.dart';
import 'package:modi/common/components/study_bottom_button.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/view_models/study/study_info_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/update_study_viewmodel.dart';
import '../../create/widgets/create_widget_resources.dart';

class StudyUpdateScreen extends StatelessWidget {
  final int studyId;

  const StudyUpdateScreen({super.key, required this.studyId});

  @override
  Widget build(BuildContext context) {
    final UpdateStudyViewModel viewModel = context.read<UpdateStudyViewModel>();
    viewModel.getStudyInfo(context, studyId);
    return Consumer<UpdateStudyViewModel>(builder: (context, viewModel, _) {
      return DefaultLayout(
          floatingActionButton: StudyBottomButton(
              onTap: (viewModel.checkEverythingFilled())
                  ? () {
                      viewModel.updateStudyInfo(context);
                    }
                  : null,
              text: '수정하기',
              color: (viewModel.checkEverythingFilled())
                  ? null
                  : AppColors.gray200),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          title: getNewStudyTitle(isCreate: false),
          child: (viewModel.isLoading) ? const CircularIndicator() : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StudyProfileImage(
                  isCreate: false,
                  viewModel: viewModel,
                ),
                StudyTextField(
                  type: NewStudyType.studyName,
                  viewModel: viewModel,
                ),
                StudyTextField(
                  type: NewStudyType.studyDescription,
                  viewModel: viewModel,
                ),
                StudyCategorySelector(
                  viewModel: viewModel,
                ),
                StudyMemberCount(
                  viewModel: viewModel,
                ),
              ],
            ),
          ));
    });
  }
}
