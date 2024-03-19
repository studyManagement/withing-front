import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/views/study/widgets/study_main_appbar.dart';
import '../../common/components/exception/modi_exception.dart';

class StudyErrorPage extends StatelessWidget {
  const StudyErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        leader: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
            context.pop();
            }),
      child: Column(
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
