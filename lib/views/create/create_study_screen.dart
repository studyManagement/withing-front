import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/image/study_image_create_service.dart';
import 'widgets/create_widget_resources.dart';
import '../../service/create/study_create_service.dart';
import '../../common/layout/default_layout.dart';
import '../../di/injection.dart';
import '../../view_models/create/create_study_viewmodel.dart';
import '../search/widgets/gray50_divider.dart';

class CreateStudyScreen extends StatelessWidget {
  const CreateStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateStudyViewModel(
          getIt<StudyCreateService>(), getIt<StudyImageCreateService>()),
      child: Consumer<CreateStudyViewModel>(
        builder: (context, viewModel, child) {
          return DefaultLayout(
            title: getNewStudyTitle(),
            child: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StudyProfileImage(),
                  StudyTextField(type: NewStudyType.studyName),
                  StudyTextField(type: NewStudyType.studyDescription),
                  StudyCategorySelector(),
                  StudyMemberCount(),
                  Gray50Divider(dividerHeight: 6),
                  StudyDiscloseToggle(),
                  StudyBasicButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
