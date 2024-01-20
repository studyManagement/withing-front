import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:withing/model/study/regular_meeting_exception.dart';
import 'package:withing/model/study/regular_meeting_model.dart';
import 'package:withing/model/study/study_model.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/service/study/study_service.dart';

final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];

class StudyRegularMeeting {
  int studyId;
  int gap;
  List<int> days;
  String startTime;
  String endTime;

  StudyRegularMeeting(
      this.studyId, this.gap, this.days, this.startTime, this.endTime);

  factory StudyRegularMeeting.from(RegularMeetingModel model) {
    return StudyRegularMeeting(
        model.studyId, model.gap, model.days, model.startTime, model.endTime);
  }

  DateTime getPromiseDays(DateTime selectedDay) {
    int weekday = selectedDay.weekday;
    List<int> days = this.days.where((element) => element > 0).toList();

    days.sort();

    int currentIndex = days.indexOf(weekday);

    List<DateTime> daysToDateTime = [];
    for (final i in days) {
      if (i == days[currentIndex]) {
        daysToDateTime.add(selectedDay);
      } else if (i > days[currentIndex]) {
        daysToDateTime
            .add(selectedDay.add(Duration(days: (i - days[currentIndex]))));
      } else if (i < days[currentIndex]) {
        daysToDateTime.add(selectedDay.add(Duration(days: i)));
      }
    }

    if (currentIndex + 1 == days.length) {
      return daysToDateTime[0];
    } else {
      return daysToDateTime[currentIndex + 1];
    }
  }

  String getNextWeek(DateTime selectedDay) {
    int weekday = selectedDay.weekday;
    List<int> days = this.days.where((element) => element > 0).toList();
    int currentIndex = days.indexOf(weekday);

    if (currentIndex + 1 == days.length) {
      return _weekString[days[0] - 1];
    } else {
      return _weekString[days[currentIndex + 1] - 1];
    }
  }

  bool hasSelectedDay(DateTime selectedDay) {
    int weekday = selectedDay.weekday;
    Iterable<int> days = this.days.where((element) => element > 0);
    return days.contains(weekday);
  }

  @override
  @override
  String toString() {
    return "StudyRegularMeeting(studyId=$studyId,gap=$gap,days=$days,startTime=$startTime,endTime=$endTime)";
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

  String getNextDay(DateTime selectedDay) {
    final nextDay = regularMeetings.first.getPromiseDays(selectedDay);
    final DateFormat formatter = DateFormat('yyyy.MM.dd');
    return formatter.format(nextDay);
  }

  String getNextWeek(DateTime selectedDay) {
    return regularMeetings.first.getNextWeek(selectedDay);
  }

  bool hasSelectedDay(DateTime selectedDay) {
    return regularMeetings
        .where((element) => element.hasSelectedDay(selectedDay))
        .isNotEmpty;
  }

  @override
  String toString() {
    return "StudyView(studyId=$studyId,studyName=$studyName,max=$max,headcount=$headcount,isPrivate=$isPrivate,isFinished=$isFinished,explanation=$explanation,createdDate=$createdDate,deadline=$deadline,leaderId=$leaderId,regularMeetings=$regularMeetings)";
  }
}

class StudyViewModel extends ChangeNotifier {
  final StudyService _service;
  late DateTime selectedDate;
  List<StudyView> _studyViews = [];

  String weekString = '';
  List<StudyView> studyViews = [];
  List<StudyView> studyViewsInSelectedDay = [];

  StudyViewModel(this._service);

  Future<void> fetchStudies(StudyType studyType) async {
    List<StudyModel> studyModels = await _service.fetchMyStudies(studyType);
    List<StudyView> studyViews = await Future.wait(studyModels
        .map((e) => StudyView.from(e))
        .map((e) => matchStudyAndMeetings(e)));

    _studyViews = studyViews;
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
    selectedDate = dateTime;
    weekString = _weekString[dateTime.weekday - 1];
    studyViews = _studyViews;
    studyViewsInSelectedDay = _studyViews
        .where((element) => element.hasSelectedDay(dateTime))
        .toList();

    notifyListeners();
  }
}
