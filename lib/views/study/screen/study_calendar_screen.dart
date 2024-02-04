import 'package:flutter/material.dart';
import 'package:modi/views/board/widgets/board_list.dart';
import 'package:modi/views/board/widgets/no_post.dart';

import '../../board/widgets/board_appbar.dart';

class StudyCalendarScreen extends StatelessWidget {
  // final int studyId;

  // const StudyCalendarScreen({super.key, required this.studyId});
  const StudyCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isExist = true;
    return Scaffold(
        appBar: boardAppBar(
            context,
            '일정',
            null,
            IconButton(
                onPressed: () {
                  // context.push('/studies/$studyId/calendar/create');
                },
                icon: const Icon(Icons.add))),
        body: SafeArea(child: (isExist) ? BoardList() : const NoPost()));
  }
}
