import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';
class BoardHeader extends StatelessWidget{
  const BoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
     padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 12.0),
     child: Column(
       children: [
         Row(
           children: [
             SizedBox(
               width: 38,
               height: 38,
               child: Container(
                 decoration: const BoxDecoration(
                   // image 추가 필요
                   shape: BoxShape.circle,
                   color: AppColors.gray150,
                 ),
               ),
             ),
             const SizedBox(width: 12),
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   '게시글 제목',
                   style: Theme.of(context).textTheme.bodyMedium,
                 ),
                 Row(
                   children: [
                     Text(
                       'nickname',
                       style: Theme.of(context)
                           .textTheme
                           .bodySmall
                           ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
                     ),
                     const SizedBox(width: 8),
                     Text(
                       '|',
                       style: Theme.of(context)
                           .textTheme
                           .bodySmall
                           ?.copyWith(color: AppColors.gray150, fontSize: 13.0),
                     ),
                     const SizedBox(width: 8),
                     Text(
                       '2023. 08. 20. 22:20',
                       style: Theme.of(context)
                           .textTheme
                           .bodySmall
                           ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
                     ),
                   ],
                 ),
               ],
             ),
           ],
         ),
         const SizedBox(height:12),
         Text("게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다."
             " 게시글 내용입니다.게시글 내용입니다. 게시글 내용입니다 .게시글 내용입니다. 게시글 내용입니다 "
    ,
         style: Theme.of(context).textTheme.bodySmall)
       ],
     ),
   );

  }

}
