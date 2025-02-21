import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/components/gray100_divider.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/view_models/board/board_input_viewmodel.dart';
import 'package:modi/views/board/widgets/board_submit_button.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import 'package:modi/views/board/widgets/post_image_list_view.dart';
import 'package:modi/views/board/widgets/user_mention_list.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/circle_button.dart';
import '../../../common/modal/modi_modal.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../di/injection.dart';
import '../../../view_models/board/board_viewmodel.dart';
import '../../../view_models/image/image_picker_viewmodel.dart';
import '../widgets/mentionable_text_field.dart';
import '../widgets/post_category_selector.dart';
import 'board_info_screen.dart';

class CreatePostScreen extends StatelessWidget {
  final BoardViewModel viewModel;

  const CreatePostScreen({super.key, required this.viewModel});

  void _showCancelDialog(BuildContext context) {
    ModiModal.openDialog(
      context,
      '글 작성을 취소하시겠어요?',
      '페이지를 벗어나면\n입력된 내용이 모두 사라져요.',
      true,
      () {
        context
          ..pop()
          ..pop();
        viewModel.updateSelectedCategory(-1);
        viewModel.imageFilePaths = [];
      },
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel.fetchStudyMembers();
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: DefaultLayout(
        title: '',
        leader: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _showCancelDialog(context), // 취소 시 다이얼로그 표시
        ),
        centerTitle: true,
        actions: [
          BoardSubmitButton(
            onSubmitted: () {
              if (viewModel.isValid) {
                viewModel.createPost(context).then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BoardInfoScreen(
                        boardId: viewModel.boardId!,
                        viewModel: viewModel,
                      ),
                    ),
                  );
                  viewModel.refreshBoardList();
                });
              }
            },
          ),
        ],
        child: ChangeNotifierProvider(
          create: (_) => BoardInputViewModel(isMember: viewModel.isMember),
          child: Consumer<BoardInputViewModel>(
            builder: (context, inputViewModel, _) => SafeArea(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      //  mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: Text('게시글 카테고리',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.gray500)),
                        ),
                        const SizedBox(height: 20),
                        Consumer<BoardViewModel>(
                            builder: (context, viewModel, _) =>
                                PostCategorySelector(
                                  postCategories: viewModel.postCategories,
                                  selectedIndex:
                                      viewModel.selectedPostCategoryIndex,
                                )),
                        const SizedBox(height: 20),
                        const Gray100Divider(),
                        BoardTextField(
                          onChanged: (value) {
                            viewModel.isValidInput(
                                BoardInputType.boardTitle, value);
                          },
                          onEditingCompleted: () {
                            if (viewModel.isValid) {
                              viewModel.createPost(context).then((_) => {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BoardInfoScreen(
                                                    boardId: viewModel.boardId!,
                                                    viewModel: viewModel))),
                                    viewModel.refreshBoardList()
                                  });
                            }
                          },
                        ),
                        const Gray100Divider(),
                        MentionableTextField(
                          type: BoardInputType.boardContents,
                          onChanged: (value) {
                            viewModel.isValidInput(
                                BoardInputType.boardContents, value);
                            viewModel.isShowUserList =
                                inputViewModel.isShowUserList();
                          },
                          onEditingCompleted: () {
                            if (viewModel.isValid) {
                              viewModel.createPost(context).then((_) => {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BoardInfoScreen(
                                                    boardId: viewModel.boardId!,
                                                    viewModel: viewModel))),
                                    viewModel.refreshBoardList()
                                  });
                            }
                          },
                        ),
                        Consumer<BoardViewModel>(
                          builder: (context, viewModel, _) => Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: SizedBox(
                                height: 120,
                                child: PostImageListView(
                                    imagePathList: viewModel.imageFilePaths,
                                    onRemove: (int index) =>
                                        viewModel.removeImage(index))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Gray100Divider(),
                  Consumer<BoardViewModel>(
                    builder: (context, viewModel, _) {
                      return viewModel.isShowUserList
                          ? UserMentionList(
                              users: viewModel.studyMembers,
                              onSelected: (user) {
                                inputViewModel.updateInnerText(user.nickname);
                                viewModel.addMentionedUserList(user);
                              })
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleButton(
                                    onTap: () => viewModel.pickMultiPhoto(),
                                    image: Image.asset(
                                      'asset/board/photo.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  CircleButton(
                                    onTap: () {},
                                    image: Image.asset(
                                      'asset/board/mention.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
