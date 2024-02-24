import 'package:flutter/cupertino.dart';
import 'package:modi/common/components/exception/modi_exception.dart';

class StudyScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModiException(const ['생성된 일정이 없어요.']);
  }

  const StudyScheduleScreen({super.key});
}
