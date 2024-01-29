import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/service/study/study_service.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';
import 'package:withing/views/board/widgets/board_list.dart';
import 'package:withing/views/board/widgets/no_post.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../di/injection.dart';
import '../widgets/board_appbar.dart';

class BoardMainScreen extends StatelessWidget {
  final int studyId;
  final bool isNotice;

  const BoardMainScreen(
      {super.key, required this.studyId, required this.isNotice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: boardAppBar(
          context,
          '게시판',
          null,
          IconButton(
              onPressed: () {
                context.push('/studies/$studyId/boards/create');
              },
              icon: const Icon(Icons.add))),
      body: ChangeNotifierProvider(
        create:(_)=>StudyViewModel(getIt<StudyService>()),
        child: Consumer<StudyViewModel>(
          builder:(context,data,child){
            data.fetchBoards(studyId, false);
          return SafeArea(child: (data.hasPost) ? const BoardList() : const NoPost());}
        ),
      ),
    );
  }
}
