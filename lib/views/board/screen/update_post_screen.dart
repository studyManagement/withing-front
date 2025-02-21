import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/views/board/widgets/board_submit_button.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/circle_button.dart';
import '../../../common/components/gray100_divider.dart';
import '../../../common/modal/modi_modal.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/board/board_input_viewmodel.dart';
import '../../../view_models/board/board_viewmodel.dart';
import '../widgets/board_appbar.dart';
import '../widgets/mentionable_text_field.dart';
import '../widgets/post_category_selector.dart';
import '../widgets/post_image_list_view.dart';
import '../widgets/user_mention_list.dart';

class UpdatePostScreen extends StatelessWidget {
  final BoardViewModel viewModel;

  const UpdatePostScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // viewModel.selectedPostCategoryIndex = ?? 초기화
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: DefaultLayout(
        title: '',
        leader: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              ModiModal.openDialog(context, '글 작성을 취소하시겠어요?',
                  '페이지를 벗어나면\n입력된 내용이 모두 사라져요.', true, () {
                context
                  ..pop()
                  ..pop();
              }, null);
            }),
        centerTitle: true,
        actions: [
          BoardSubmitButton(
            onSubmitted: () {
              (viewModel.isValid)
                  ? {
                      viewModel.updatePost(context, viewModel.post!.id),
                      context.pop(),
                      viewModel.refreshBoardList()
                    }
                  : null;
            },
          )
        ],
        child: (viewModel.post == null)
            ? Container()
            : ChangeNotifierProvider(
                create: (_) => BoardInputViewModel(
                    initTitle: viewModel.post!.title,
                    initContent: viewModel.post!.content,
                    isMember: viewModel.isMember),
                child: Consumer<BoardInputViewModel>(
                  builder:(context, inputViewModel, _) =>  SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                            viewModel
                                .updatePost(context, viewModel.post!.id)
                                .then((_) => {
                                      context.pop(),
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
                            viewModel.isShowUserList = inputViewModel.isShowUserList();
                          },
                          onEditingCompleted: () {
                            if (viewModel.isValid) {
                              viewModel
                                  .updatePost(context, viewModel.post!.id)
                                  .then((_) => {
                                        context.pop(),
                                        viewModel.refreshBoardList()
                                      });
                            }
                          }),
                      Consumer<BoardViewModel>( // 수정 필요
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
                  )),
                ),
              ),
      ),
    );
  }
}
