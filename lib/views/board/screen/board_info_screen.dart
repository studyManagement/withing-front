import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/components/gray50_divider.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';
import '../widgets/board_appbar.dart';
import '../widgets/board_bottomsheet.dart';
import '../widgets/board_header.dart';
import '../widgets/comment_input_box.dart';
import '../widgets/comment_list.dart';

class BoardInfoScreen extends StatelessWidget {
  final int boardId;
  final BoardViewModel viewModel;

  const BoardInfoScreen({super.key, required this.boardId, required this.viewModel});

  void loadBoardInfo() {
    viewModel.fetchBoardInfo(boardId);
    viewModel.fetchComments(boardId);
  }

  @override
  Widget build(BuildContext context) {
    loadBoardInfo();
    final ScrollController scrollController = ScrollController();
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<BoardViewModel>(builder: (context, consumer, child) {
        bool isWriter =
            consumer.post?.user.id == Authentication.instance.userId;
        if (consumer.isAddedComment) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }
        return Scaffold(
            appBar: boardAppBar(context, '', () {
              context.pop();
            },
                (isWriter)
                    ? IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BoardBottomSheet(
                                    viewModel: consumer, boardId: boardId);
                              });
                        },
                        icon: const Icon(Icons.more_horiz))
                    : null),
            body: (consumer.post == null)
                ? Container()
                : SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: const Column(children: [
                              BoardHeader(),
                              Gray50Divider(
                                dividerHeight: 6.0,
                              ),
                              SizedBox(height: 12),
                              BoardCommentList(),
                            ]),
                          ),
                        ),
                        const Gray50Divider(),
                        CommentInputBox(viewModel: viewModel)
                      ],
                    ),
                  ));
      }),
    );
  }
}
