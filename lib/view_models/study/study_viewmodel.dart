import 'package:flutter/material.dart';
import 'package:withing/common/requester/network_exception.dart';
import 'package:withing/model/study/study_category_model.dart';
import 'package:withing/model/study/study_model.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/service/study/study_service.dart';

class StudyViewModel extends ChangeNotifier {
  final StudyService _service;
  DateTime _selectedDateTime = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<StudyModel> _fetchMyStudies = List.empty();
  List<StudyModel> myStudies = List.empty();
  var study;
  List<String> categories = List.empty();

  StudyViewModel(this._service);

  Future<void> fetchStudies(StudyType studyType) async {
    _fetchMyStudies = await _service.fetchMyStudies(studyType);

    final regularMeetings =
        _fetchMyStudies.map((e) => _service.fetchRegularMeeting(e.studyId));
    await Future.wait(regularMeetings);

    notifyListeners();
  }

  Future<void> fetchStudyInfo(int studyId) async {
    if (study == null) {
      try {
        study = await _service.fetchStudyInfo(studyId);
        notifyListeners();
      } on NetworkException catch(e) {
        print(e);
      }
    }

  }

  Future<void> fetchCategories(int studyId) async{
    var categoryModel = await _service.fetchStudyCategory(studyId);
    if(categoryModel.category1 != null) categories.add(categoryModel.category1!);
    if(categoryModel.category2 != null) categories.add(categoryModel.category2!);
    if(categoryModel.category3 != null) categories.add(categoryModel.category3!);
  }

  void setSelectedDate(DateTime dateTime) {
    _selectedDateTime = dateTime;
  }
}
