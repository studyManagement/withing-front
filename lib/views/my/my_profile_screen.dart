import 'package:flutter/cupertino.dart';
import 'package:modi/common/layout/default_layout.dart';

class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        title: '프로필 수정',
        child: SafeArea(
          child: Text('h'),
        ));
  }
}
