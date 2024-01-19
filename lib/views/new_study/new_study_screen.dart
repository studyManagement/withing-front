import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'widgets/_new_study_widget_resources.dart';
import '../search/widgets/gray50_divider.dart';
import '../../view_models/new_study/new_study_view_model.dart';

class NewStudyScreen extends StatelessWidget {
  const NewStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewStudyViewModel(),
      child: Consumer<NewStudyViewModel>(
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
