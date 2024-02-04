import 'package:flutter/material.dart';
import 'package:modi/views/study/widgets/study_main_appbar.dart';

class StudyExceptionScreen extends StatelessWidget {
  const StudyExceptionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: studyMainAppBar(context, false, -1),
      body: SafeArea(child: Center(child: Text("해당하는 스터디 정보가 없습니다."))),
    );
  }
}
