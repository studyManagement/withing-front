import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/gray100_divider.dart';
import 'package:modi/views/board/widgets/board_submit_button.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import 'package:provider/provider.dart';
import '../../../common/modal/withing_modal.dart';
import '../../../view_models/board/board_viewmodel.dart';
import '../widgets/board_appbar.dart';

class CreatePostScreen extends StatelessWidget {
  final BoardViewModel viewModel;

  const CreatePostScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
                ChangeNotifierProvider.value(
                  value: viewModel,
                  child: BoardSubmitButton(
                    onSubmitted: () {
                      (viewModel.isValid)
                          ? {
                              viewModel.createPost(),
                              context.pop(),
                        viewModel.refreshBoardList()
                            }
                          : null;
                    },
                  ),
                )),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  BoardTextField(type: BoardInputType.boardTitle, isNew: true,viewModel: viewModel),
                  const Gray100Divider(),
                  BoardTextField(type: BoardInputType.boardContents, isNew: true, viewModel: viewModel)
                ],
              ),
            )),
    );

  }
}
