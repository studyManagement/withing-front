import 'package:flutter/material.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../di/injection.dart';
import '../../../service/study/study_service.dart';

class StudyUpdateScreen extends StatelessWidget {
  final int studyId;

  const StudyUpdateScreen({super.key, required this.studyId});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '스터디 정보 수정',
        child: ChangeNotifierProvider(
          create: (_) => StudyViewModel(getIt<StudyService>()),
          child: Consumer<StudyViewModel>(builder: (context, data, child) {
            data.fetchStudyInfo(context, studyId);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: Center(
                      child: Container(
                        width: 105,
                        height: 105,
                          // decoration: (data.study.studyImage != null) ?
                          // ShapeDecoration(
                          //   shape: const OvalBorder(),
                          //   image: DecorationImage(
                          //     image: FileImage(data.study.studyImage!),
                          //     fit: BoxFit.cover,
                          //   ),
                          // )
                          //     :
                         decoration: const ShapeDecoration(
                            shape: OvalBorder(),
                            color: AppColors.gray150,
                          ),
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () async {
                            debugPrint('프로필 사진 선택');
                            //   data.study.studyImage = await pickImageFile();
                          },
                          child: Image.asset(
                            'asset/camera.png',
                            scale: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }),
        ));
  }
}
