import 'package:flutter/cupertino.dart';
import 'package:withing/model/study/study_list_model.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/service/study/study_service.dart';
import 'package:withing/view_models/study/model/study_list_view.dart';
import 'package:withing/view_models/study/model/study_meeting_schedule.dart';

class StudyListViewModel extends ChangeNotifier {
  final StudyService _service;
  List<StudyListView> studyListView = [];
  List<StudyListView> selectStudyListView = [];
  late DateTime selectedDate;
  String weekString = '';

  StudyListViewModel(this._service);

  Future<void> fetchStudies(StudyType studyType) async {
    List<StudyListModel> studyModels = await _service.fetchMyStudies(studyType);
    List<StudyListView> studyViews =
        studyModels.map((e) => StudyListView.from(e)).toList();
    List<StudyListView> studyViewSpread = [];

    studyListView = studyViews;

    studyViews
        .where((element) => element.hasStudies(selectedDate))
        .forEach((e) => studyViewSpread.addAll(e.spread()));

    selectStudyListView = studyViewSpread
        .where((element) => element.hasStudies(selectedDate))
        .toList();

    notifyListeners();
  }

  StudyMeetingSchedule getNextPromise(StudyListView currentStudy) {
    int weekday = currentStudy.meetingSchedules.first.day;

    StudyMeetingSchedule currentMeetingSchedule =
        currentStudy.meetingSchedules.first;

    StudyListView study =
        studyListView.firstWhere((element) => element.id == currentStudy.id);

    study.meetingSchedules.sort((a, b) => a.day - b.day);

    int currentDateIndex = study.meetingSchedules
        .indexWhere((element) => element.id == currentMeetingSchedule.id);

    if (study.meetingSchedules.length == currentDateIndex + 1) {
      return study.meetingSchedules[0];
    }

    return study.meetingSchedules[currentDateIndex + 1];
  }

  void setSelectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    weekString = WeekString[dateTime.weekday - 1];
  }
}
