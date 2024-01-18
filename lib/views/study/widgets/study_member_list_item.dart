import 'package:flutter/material.dart';

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
         Container(
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
