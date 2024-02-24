import 'package:flutter/material.dart';
import 'package:modi/common/components/study/study_list.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

class MyStudyScreen extends StatelessWidget {
  String studyType;

  MyStudyScreen(this.studyType, {super.key});

  @override
  Widget build(BuildContext context) {
    StudyListViewModel vm = context.read<StudyListViewModel>();
    vm.fetchStudies(StudyType.from(studyType));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          (StudyType.from(studyType) == StudyType.LIKE) ? '찜한 스터디' : '종료된 스터디',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: MyStudyListView(),
        ),
      ),
    );
  }
}

class MyStudyListView extends StatelessWidget {
  const MyStudyListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.studyList);

    List<StudyListViewParam> params = [];

    for (var element in studies) {
      Map<String, String> extra = {};
      extra['참여 인원'] = "${element.headcount}/${element.max}";
      extra['정기 모임'] = '블라블라';

      StudyListViewParam param = StudyListViewParam(
        element.studyName,
        '/studies/${element.id}',
        extra: extra,
        tag: element.categories,
      );

      params.add(param);
    }

    return StudyList(params);
  }
}
