import 'package:flutter/material.dart';
import 'package:withing/views/board/widgets/board_item.dart';
import '../../../common/theme/app/app_colors.dart';

class BoardCommentList extends StatelessWidget {
  const BoardCommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 452,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _CommentItem(
              image:Container(),
              nickname: 'nickname',
              commentId: 1,
              content: '게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다.'
                  ' 게시글 내용입니다.게시글 내용입니다. 게시글 내용입니다 .게시글 내용입니다. 게시글 내용입니다  ',
              createdAt: getCreatedAt('2024-01-20T00:00:00'),
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
          itemCount: 10,
      ),
    );
  }


}

class _CommentItem extends StatelessWidget {
  final int commentId;
  final String nickname;
  final String content;
  final String createdAt;
  final Widget image;

  _CommentItem({
    required this.commentId, required this.nickname, required this.content, required this.createdAt, required this.image});

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           SizedBox(
             width: 22,
             height: 22,
             child: Container(
               decoration: const BoxDecoration(
                 // image 추가 필요
                 shape: BoxShape.circle,
                 color: AppColors.gray150,
               ),
             ),
           ),
           const SizedBox(width: 8),
           Text(
             nickname,
             style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13.0),
           ),
         ],
       ),
       const SizedBox(height: 4),
       Text(
         content,
         style: Theme.of(context)
             .textTheme
             .bodySmall
         ,
       ),
       const SizedBox(height: 6),
       Text(
         createdAt,
         style: Theme.of(context)
             .textTheme
             .labelMedium?.copyWith(color: AppColors.gray400),
       ),
     ]),
   );
  }

}