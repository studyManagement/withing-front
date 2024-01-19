import 'package:flutter/material.dart';
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

  StudyViewModel(this._service);

  Future<void> fetchStudies(StudyType studyType) async {
    _fetchMyStudies = await _service.fetchMyStudies(studyType);

    final regularMeetings =
        _fetchMyStudies.map((e) => _service.fetchRegularMeeting(e.studyId));
    await Future.wait(regularMeetings);

    notifyListeners();
  }

  void setSelectedDate(DateTime dateTime) {
    _selectedDateTime = dateTime;
  }
}
