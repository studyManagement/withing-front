import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/components/gray50_divider.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/view_models/board/board_input_viewmodel.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import 'package:modi/views/board/widgets/mentionable_text_field.dart';
import 'package:provider/provider.dart';
import '../../../common/components/gray100_divider.dart';
import '../widgets/board_bottomsheet.dart';
import '../widgets/board_content.dart';
import '../widgets/comment_list.dart';
import '../widgets/user_mention_list.dart';

class BoardInfoScreen extends StatelessWidget {
  final int boardId;
  final BoardViewModel viewModel;

  const BoardInfoScreen(
      {super.key, required this.boardId, required this.viewModel});

  void loadBoardInfo(BuildContext context) {
    viewModel.fetchBoardInfo(context, boardId);
    viewModel.fetchComments(context, boardId);
    viewModel.fetchStudyMembers();
  }

  @override
  Widget build(BuildContext context) {
    loadBoardInfo(context);
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
        return DefaultLayout(
            title: '',
            leader: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.pop();
                }),
            centerTitle: true,
            actions: [
              if (isWriter)
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BoardBottomSheet(
                                viewModel: consumer, boardId: boardId);
                          });
                    },
                    icon: const Icon(Icons.more_horiz))
            ],
            child: (consumer.post == null)
                ? Container()
                : ChangeNotifierProvider(
                    create: (_) =>
                        BoardInputViewModel(isMember: viewModel.isMember),
                    child: Consumer<BoardInputViewModel>(
                      builder: (context, inputViewModel, _) => SafeArea(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: const Column(children: [
                                  BoardContent(),
                                  Gray50Divider(
                                    dividerHeight: 6.0,
                                  ),
                                  SizedBox(height: 12),
                                  BoardCommentList(),
                                ]),
                              ),
                            ),
                            const Gray100Divider(),
                            if (viewModel.isShowUserList &&
                                viewModel.studyMembers.isNotEmpty)
                              UserMentionList(
                                  users: viewModel.studyMembers,
                                  onSelected: (user) {
                                    inputViewModel
                                        .onTagSelected(user.nickname);
                                    viewModel.addMentionedUserList(BoardInputType.comment, user, inputViewModel.text);
                                  }),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: MentionableTextField(
                                    type: BoardInputType.comment,
                                    onChanged: (value) {
                                      viewModel.isValidInput(
                                          BoardInputType.boardContents, value);
                                      viewModel.isShowUserList =
                                          inputViewModel.isShowUserList;
                                    },
                                    onEditingCompleted: () {
                                      if (viewModel.isValid) {
                                        viewModel.createComment(
                                            context, viewModel.post!.id);
                                      }
                                      viewModel.refreshBoardList();
                                    })),
                          ],
                        ),
                      ),
                    ),
                  ));
      }),
    );
  }
}
