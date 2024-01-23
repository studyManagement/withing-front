import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:withing/model/study/regular_meeting_exception.dart';
import 'package:withing/model/study/regular_meeting_model.dart';
import 'package:withing/model/study/study_model.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/service/study/study_service.dart';

import '../../common/requester/network_exception.dart';
import '../../model/study/notice_model.dart';

final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];

class StudyRegularMeeting {
  int studyId;
  int gap;
  List<int> days;
  String startTime;
  String endTime;

  StudyRegularMeeting(this.studyId, this.gap, this.days, this.startTime,
      this.endTime);

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
  String explanation;
  int leaderId;
  String? studyImage;
  List<String> categories;
  int gap;
  List<int>? days;
  String startTime;

  List<StudyRegularMeeting> regularMeetings = [];

  StudyView(this.studyId,
      this.studyName,
      this.max,
      this.headcount,
      this.explanation,
      this.leaderId,
      this.studyImage,
      this.categories,
      this.gap,
      this.days,
      this.startTime,);

  void addRegularMeeting(StudyRegularMeeting regularMeeting) {
    regularMeetings.add(regularMeeting);
  }

  factory StudyView.from(StudyModel model) {
    return StudyView(
      model.studyId,
      model.studyName,
      model.max,
      model.headcount,
      model.explanation,
      model.leaderId,
      model.studyImage,
      model.categories,
      model.gap,
      model.days,
      model.startTime,
    );
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
    return "StudyView(studyId=$studyId,studyName=$studyName,max=$max,headcount=$headcount,explanation=$explanation,leaderId=$leaderId,studyImage=$studyImage,categories=$categories,gap=$gap,days=$days,startTime=$startTime,regularMeetings=$regularMeetings)";
  }
}

class StudyViewModel extends ChangeNotifier {
  final StudyService _service;
  late DateTime selectedDate;
  List<StudyView> _studyViews = [];

  String weekString = '';
  List<StudyView> studyViews = [];
  List<StudyView> studyViewsInSelectedDay = [];

  var study;
  List<int> days=[];
  String regularMeeting = '';

  bool hasNotice = false;
  int numOfNotices = 0;
  List<NoticeModel> notices = [];

  StudyViewModel(this._service);

  Future<void> fetchStudies(StudyType studyType) async {
    List<StudyModel> studyModels = await _service.fetchMyStudies(studyType);
    List<StudyView> studyViews = await Future.wait(studyModels
        .map((e) => StudyView.from(e))
        .map((e) => matchStudyAndMeetings(e)));

    _studyViews = studyViews;
    this.studyViews = studyViews;
    studyViewsInSelectedDay = _studyViews
        .where((element) => element.hasSelectedDay(selectedDate))
        .toList();

    notifyListeners();
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
  }

  Future<void> fetchStudyInfo(int studyId) async {
    if (study == null) {
      try {
        study = await _service.fetchStudyInfo(studyId);
        if(study.days != null) days = study.days;
        if (notices.isEmpty) {
          notices = await _service.fetchNotices(studyId);
          if (notices.isNotEmpty) {
            hasNotice = true;
            numOfNotices = notices.length;
            notifyListeners();
          }
        }
      } on NetworkException catch (e) {
        print(e);
      }
    }
  }

 String getRegularMeetingString() {
    String regularMeeting='';
    if (study.gap == 0) {
      regularMeeting = '매일 ${study.startTime.substring(0, 5)}';
    }
    else if (study.gap == 1) {
      regularMeeting = '매주 ';
      int cnt = 0 ;
      for (int i = 0; i < days.length; i++) {
        if (cnt<days.length){
          regularMeeting = '$regularMeeting${_weekString[days[i]]}, ';
          cnt++;
        }
        else{
          regularMeeting = '$regularMeeting${_weekString[days[i]]} ';
        }
      }
    }
    else {
      print('잘못된 정기모임 형식');
    }
    return regularMeeting;
  }

// Future<void> fetchNotices(int studyId) async {
//   if(notices.isEmpty){
//     notices = await _service.fetchNotices(studyId);
//     if(notices.isNotEmpty){
//       hasNotice = true;
//       numOfNotices = notices.length;
//       notifyListeners();
//     }
//   }
// }

// Future<void> fetchCategories(int studyId) async {
//   var categoryModel = await _service.fetchStudyCategory(studyId);
//   if (categoryModel.category1 != null)
//     categories.add(categoryModel.category1!);
//   if (categoryModel.category2 != null)
//     categories.add(categoryModel.category2!);
//   if (categoryModel.category3 != null)
//     categories.add(categoryModel.category3!);
//
// }
}
