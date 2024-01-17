import 'package:flutter/material.dart';
import 'package:withing/common/layout/default_layout.dart';

import '../../common/theme/app/app_colors.dart';

 class StudyMemberScreen extends StatelessWidget{
  const StudyMemberScreen({super.key});

   @override
  Widget build(BuildContext context){
     return DefaultLayout(
       title: "참여 인원",
      child: ListView.separated(
          itemBuilder: (context, index) {
            return StudyMemberListItem(
              nickname: "nickname",
              image: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray150,
              ),
            ),);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.gray100,
            );
          },
          itemCount: 10),
     );
   }
 }

class StudyMemberListItem extends StatelessWidget {
  final String nickname;
  final Widget image;

  const StudyMemberListItem(
      {super.key,
        required this.nickname,
        required this.image,
       });

  @override
  Widget build(BuildContext context) {
    bool isLeader = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 38,
            height: 38,
            child: image
          ),
          const SizedBox(width:12),
          Text(nickname,style: Theme.of(context).textTheme.titleSmall,),
          const SizedBox(width:12),
          Offstage(
            offstage: (isLeader==true)? false : true,
              child: Image.asset('asset/leader_20.png',width: 20,height: 20,))
        ],
      ),
    );
  }
}
