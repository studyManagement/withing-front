import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/views/board/widgets/board_submit_button.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import 'package:provider/provider.dart';
import '../../../common/modal/withing_modal.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../di/injection.dart';
import '../../../view_models/board/board_viewmodel.dart';
import '../widgets/board_appbar.dart';

class UpdatePostScreen extends StatelessWidget {
  final int studyId;
  final int boardId;

  const UpdatePostScreen(
      {super.key, required this.studyId, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BoardViewModel(getIt<BoardService>()),
        child: Consumer<BoardViewModel>(builder: (context, vm, child) {
          vm.setStudyId = studyId;
          vm.fetchBoardInfo(boardId);
          return Scaffold(
            appBar: boardAppBar(
                context,
                '',
                () => {
                      WithingModal.openDialog(context, '글 작성을 취소하시겠어요?',
                          '페이지를 벗어나면\n입력된 내용이 모두 사라져요.', true, () {
                        context
                          ..pop()
                          ..pop();
                      }, null)
                    },
                BoardSubmitButton(isNew: false, boardId: boardId)),
            body: (vm.post == null)
                ? Container()
                : SafeArea(
                    child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        BoardTextField(
                            type: BoardInputType.boardTitle,
                            initValue: vm.post!.title),
                        const Divider(
                          color: AppColors.gray100,
                        ),
                        BoardTextField(
                            type: BoardInputType.boardContents,
                            initValue: vm.post!.content)
                      ],
                    ),
                  )),
          );
        }));
  }
}
