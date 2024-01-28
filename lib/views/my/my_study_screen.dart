import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/view_models/study/model/study_list_view.dart';
import 'package:withing/view_models/study/study_list_viewmodel.dart';

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
          title: const Text(
            '프로필',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: const SafeArea(child: MyStudyListView()));
  }
}

class MyStudyListView extends StatelessWidget {
  const MyStudyListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.studyListView);
    return ListView.builder(
        itemCount: studies.length,
        itemBuilder: (BuildContext context, int index) {
          StudyListView study = studies[index];
          return Text(study.studyName);
        });
  }
}
