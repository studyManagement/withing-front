import 'package:flutter/cupertino.dart';
import 'package:withing/common/layout/default_layout.dart';

class MyStudyScreen extends StatelessWidget {
  const MyStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        title: '스터디',
        child: SafeArea(
          child: Text('d'),
        ));
  }
}
