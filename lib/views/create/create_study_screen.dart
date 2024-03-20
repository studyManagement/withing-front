import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:provider/provider.dart';
import '../../common/components/gray50_divider.dart';
import '../../common/components/study_bottom_button.dart';
import '../../common/theme/app/app_colors.dart';
import '../../service/image/image_create_service.dart';
import '../../view_models/study/study_info_viewmodel.dart';
import 'widgets/create_widget_resources.dart';
import '../../service/create/study_create_service.dart';
import '../../common/layout/default_layout.dart';
import '../../di/injection.dart';
import '../../view_models/study/create_study_viewmodel.dart';


class CreateStudyScreen extends StatelessWidget {
  const CreateStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateStudyViewModel(
          getIt<StudyCreateService>(), getIt<ImageCreateService>()),
      child: Consumer<CreateStudyViewModel>(
        builder: (context, viewModel, child) {
          return DefaultLayout(
            title: getNewStudyTitle(isCreate: true),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StudyProfileImage(
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
                  StudyMemberCount(viewModel: viewModel),
                  const Gray50Divider(dividerHeight: 6),
                  const StudyDiscloseToggle(),
                  StudyBottomButton(
                      onTap: (viewModel.checkEverythingFilled())
                          ? () {
                              viewModel.createStudy().then((_) =>
                                  context.pushReplacement(
                                      '/studies/${viewModel.studyId}'));
                            }
                          : null,
                      text: '생성하기',
                      color: (viewModel.checkEverythingFilled())
                          ? null
                          : AppColors.gray200),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
