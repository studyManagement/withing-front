import 'package:flutter/material.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/gray_container.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../common/utils/get_created_string.dart';

class BoardCommentList extends StatelessWidget {
  const BoardCommentList({super.key});

  @override
  Widget build(BuildContext context) {
    final BoardViewModel vm = context.watch<BoardViewModel>();
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return _CommentItem(
          image: vm.comments[index].user.profileImage,
          nickname: vm.comments[index].user.nickname,
          commentId: vm.comments[index].id,
          content: vm.comments[index].contents,
          createdAt: getCreatedAt(vm.comments[index].createdAt.toString()),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
          color: AppColors.gray100,
        );
      },
      itemCount: vm.comments.length,
    );
  }
}

class _CommentItem extends StatelessWidget {
  final int commentId;
  final String nickname;
  final String content;
  final String createdAt;
  final String? image;

  const _CommentItem(
      {required this.commentId,
      required this.nickname,
      required this.content,
      required this.createdAt,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImage(
                size: 22,
                image: (image == null)
                    ? null
                    : Image.network(
                        image!,
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const GrayContainer(size: 22);
                        },
                      )),
            const SizedBox(width: 8),
            Text(
              nickname,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 13.0),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        Text(
          createdAt,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: AppColors.gray400),
        ),
      ]),
    );
  }
}
