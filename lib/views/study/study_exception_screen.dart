import 'package:flutter/material.dart';
import 'package:modi/views/study/widgets/study_main_appbar.dart';

class StudyExceptionScreen extends StatelessWidget {
  const StudyExceptionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StudyMainAppBar(
        studyId: -1,
        isLeader: false,
      ),
      body: SafeArea(child: Center(child: Text("해당하는 스터디 정보가 없습니다."))),
    );
  }
}
