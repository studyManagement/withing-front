import 'package:flutter/material.dart';
import 'package:modi/common/layout/default_layout.dart';
import '../../../model/user/user_model.dart';
import '../widgets/study_member_list.dart';


class StudyMemberScreen extends StatelessWidget {
  final List<UserModel> users;

  const StudyMemberScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: "참여 인원", child: StudyMemberList(users: users));

  }
}
