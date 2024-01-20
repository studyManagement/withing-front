import 'package:flutter/material.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/common/modal/withing_modal.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/views/study/widgets/study_manage_bottomsheet.dart';

class StudyEditScreen extends StatelessWidget {
  const StudyEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '스터디 정보 수정',
        child: Container()
    );
  }
}

