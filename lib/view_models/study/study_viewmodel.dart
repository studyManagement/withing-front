import 'package:flutter/material.dart';
import 'package:withing/model/study/regular_meeting_exception.dart';
import 'package:withing/model/study/regular_meeting_model.dart';
import 'package:withing/model/study/study_model.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/service/study/study_service.dart';

class StudyRegularMeeting {
  int regularMeetingId;
  int gap;
  int day1;
  int day2;
  int day3;
  String startTime;
  String endTime;

  StudyRegularMeeting(this.regularMeetingId, this.gap, this.day1, this.day2,
      this.day3, this.startTime, this.endTime);

  factory StudyRegularMeeting.from(RegularMeetingModel model) {
    return StudyRegularMeeting(model.regularMeetingId, model.gap, model.day1,
        model.day2, model.day3, model.startTime, model.endTime);
  }

  bool hasSelectedDay(DateTime selectedDay) {
    int weekday = selectedDay.weekday - 1;
    List<int> days = [day1, day2, day3];
    return days.contains(weekday);
  }

  @override
  String toString() {
    return "StudyRegularMeeting(regularMeetingId=$regularMeetingId,gap=$gap,day1=$day1,day2=$day2,day3=$day3,startTime=$startTime,endTime=$endTime)";
  }
}

class StudyView {
  int studyId;
  String studyName;
  int max;
  int headcount;
  int isPrivate;
  int isFinished;
  String explanation;
  DateTime createdDate;
  DateTime deadline;
  int leaderId;
  String? studyImage;
  List<StudyRegularMeeting> regularMeetings = [];

  StudyView(
      this.studyId,
      this.studyName,
      this.max,
      this.headcount,
      this.isPrivate,
      this.isFinished,
      this.explanation,
      this.createdDate,
      this.deadline,
      this.leaderId,
      this.studyImage);

  void addRegularMeeting(StudyRegularMeeting regularMeeting) {
    regularMeetings.add(regularMeeting);
  }

  factory StudyView.from(StudyModel model) {
    return StudyView(
        model.studyId,
        model.studyName,
        model.max,
        model.headcount,
        model.isPrivate,
        model.isFinished,
        model.explanation,
        model.createdDate,
        model.deadline,
        model.leaderId,
        model.studyImage);
  }

  bool hasSelectedDay(DateTime selectedDay) {
    return regularMeetings
        .where((element) => element.hasSelectedDay(selectedDay))
        .isNotEmpty;
    ;
  }

  @override
  String toString() {
    return "StudyView(studyId=$studyId,studyName=$studyName,max=$max,headcount=$headcount,isPrivate=$isPrivate,isFinished=$isFinished,explanation=$explanation,createdDate=$createdDate,deadline=$deadline,leaderId=$leaderId,regularMeetings=$regularMeetings)";
  }
}

class StudyViewModel extends ChangeNotifier {
  final StudyService _service;
  List<StudyModel> myStudies = List.empty();
  List<StudyView> _studyViews = [];
  List<StudyView> studyViews = [];

  StudyViewModel(this._service);

  Future<void> fetchStudies(StudyType studyType) async {
    List<StudyModel> studyModels = await _service.fetchMyStudies(studyType);
    List<StudyView> studyViews = await Future.wait(studyModels
        .map((e) => StudyView.from(e))
        .map((e) => matchStudyAndMeetings(e)));

    _studyViews = studyViews;

    setSelectedDate(DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ));
  }

  Future<StudyView> matchStudyAndMeetings(StudyView studyView) {
    return Future(() async {
      try {
        RegularMeetingModel regularMeetingModel =
            await _service.fetchRegularMeeting(studyView.studyId);
        StudyRegularMeeting regularMeeting =
            StudyRegularMeeting.from(regularMeetingModel);

        studyView.addRegularMeeting(regularMeeting);
        return studyView;
      } on RegularMeetingException catch (e) {
        return studyView;
      }
    });
  }

  void setSelectedDate(DateTime dateTime) {
    studyViews = _studyViews
        .where((element) => element.hasSelectedDay(dateTime))
        .toList();

    notifyListeners();
  }
}
