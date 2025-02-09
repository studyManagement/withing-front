import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/view_models/board/model/post_category.dart';
import 'package:modi/views/board/screen/create_post_screen.dart';
import 'package:modi/views/board/widgets/board_list.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import 'package:modi/views/board/widgets/post_category_selector.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../../../view_models/board/board_viewmodel.dart';

class BoardMainScreen extends StatelessWidget {
  final int studyId;
  final bool isNotice;
  final bool? isMember;

  const BoardMainScreen(
      {super.key,
      required this.studyId,
      required this.isNotice,
      this.isMember});

  void initCreatePostScreenState(BoardViewModel viewModel) {
    viewModel.isValid = false;
    viewModel.boardContents = '';
    viewModel.boardTitle = '';
    viewModel.isShowUserList = false;
    viewModel.updateSelectedCategory(0);
  }

  void loadBoardList(BuildContext context, BoardViewModel vm) {
    vm.setStudyId = studyId;
    vm.isMember = isMember!;
    vm.fetchNotices(context);
    if (isNotice == false) {
      vm.fetchBoardList(context);
    }
    vm.isRefreshed = false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BoardViewModel(getIt<BoardService>()),
      child: Consumer<BoardViewModel>(builder: (context, vm, child) {
        if (vm.isRefreshed) {
          loadBoardList(context, vm);
        }
        return DefaultLayout(
            title: (isNotice == true) ? '공지' : '게시판',
            leader: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.pop();
                }),
            centerTitle: true,
            actions: [
              if (!isNotice)
                IconButton(
                    onPressed: () {
                      initCreatePostScreenState(vm);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreatePostScreen(viewModel: vm)));
                    },
                    icon: const Icon(Icons.add)),
            ],
            child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isNotice)
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 6),
                    child: PostCategorySelector(
                        postCategories: [
                              PostCategory(
                                  id: -1,
                                  name: '전체',
                                  activeIcon: '',
                                  inactiveIcon: '')
                            ] +
                            vm.postCategories,
                        selectedIndex: vm.selectedPostCategoryIndex),
                  ),
                  Expanded(
                      child: vm.hasPost
                          ? BoardList(
                              isNotice: isNotice,
                            )
                          : const NoPost())
                ])));
      }),
    );
  }
}
