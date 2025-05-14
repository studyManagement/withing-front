import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/model/board/board_model.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/view_models/board/model/post_category.dart';
import 'package:modi/views/board/screen/board_info_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../common/utils/get_created_string.dart';

class BoardItem extends StatelessWidget {
  final BoardModel boardItem;
  final bool hasTag;

  const BoardItem({
    super.key,
    required this.boardItem,
    required this.hasTag,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BoardViewModel>();
    final hasImage = boardItem.images.isNotEmpty;
    final postCategory = viewModel.postCategories.firstWhere((e) => e.type.name == boardItem.category);

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BoardInfoScreen(
                    boardId: boardItem.id, viewModel: viewModel)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasTag)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Image.asset(postCategory.inactiveIcon, width: 20, height: 20),
                          const SizedBox(width: 2),
                          Text(postCategory.name, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray400))
                        ],
                      ),
                    ),
                    Text(
                      boardItem.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: hasImage ? MediaQuery.of(context).size.width * 0.7 : MediaQuery.of(context).size.width-32,
                      child: Text(
                       boardItem.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.gray800, fontSize: 13.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (hasImage)
                Container(
                  width: 64,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: AppColors.gray100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      boardItem.images[0],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            color: AppColors.gray150,
                            child: Center(
                                child: Transform.scale(
                                  scale: 0.6,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.gray600,
                                  ),
                                )),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(color: AppColors.gray150);
                      },
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${boardItem.user.nickname} | ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
              Text(
                viewModel.postCreatedText(boardItem.createdAt.toString()),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Image.asset('asset/comment.png', width: 16, height: 16),
              ),
              Text(boardItem.numOfComments.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.gray400, fontSize: 13.0))
            ],
          ),
        ]),
      ),
    );
  }
}

bool isNew(String createdAt) {
  // true: 신규 태그
  DateTime time = DateTime.parse(createdAt);
  DateTime now = DateTime.now();
  DateTime twentyFourHoursAgo = now.subtract(const Duration(hours: 24));
  return !time.isBefore(twentyFourHoursAgo);
}
