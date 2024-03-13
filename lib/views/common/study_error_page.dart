import 'package:flutter/material.dart';
import 'package:modi/views/study/widgets/study_main_appbar.dart';
import '../../common/components/exception/modi_exception.dart';

class StudyErrorPage extends StatelessWidget {
  const StudyErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StudyMainAppBar(
        studyId: -1,
        isLeader: false,
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ModiException(const [
            '이용 불가능한 스터디입니다.',
          ]),
        ),
      ],
    ),
    );
  }
}
