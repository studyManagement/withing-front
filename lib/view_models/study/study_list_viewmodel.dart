import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/model/study/study_list_model.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';

import '../../common/modal/modi_modal.dart';
import '../../common/requester/api_exception.dart';
import '../../di/injection.dart';
import '../../model/schedule/user_schedule_model.dart';
import '../../service/schedule/schedule_service.dart';

class StudyListViewModel extends ChangeNotifier {
  bool _disposed = false;

  final StudyService _service;
  final BuildContext _context;
  List<StudyListView> studyList = [];
  List<UserScheduleModel> todaySchedules = [];
  List<UserScheduleModel> thisWeekSchedules = [];
  late DateTime selectedDate = DateTime.now();
  String weekString = '';

  StudyListViewModel(this._service, this._context);

  Future<void> fetchStudies(StudyType studyType) async {
    if(studyList.isEmpty) {
      List<StudyListModel> studyModels = await _service.fetchMyStudies(
          studyType);
      List<StudyListView> studyViews =
      studyModels.map((e) => StudyListView.from(e)).toList();

      studyList = studyViews;

      notifyListeners();
    }
  }

  Future<void> fetchThisWeekSchedules() async {
    if(thisWeekSchedules.isEmpty) {
      try {
        thisWeekSchedules =
        await getIt<ScheduleService>().fetchThisWeekSchedule();
        notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
    }
  }

  filterSchedules(DateTime selectedDate) {
    todaySchedules = [];
    String dateString = DateFormat("yyyy-MM-dd").format(selectedDate);
    todaySchedules.addAll(thisWeekSchedules.where((element) => element.date == dateString));
  }

  StudyMeetingSchedule getNextPromise(StudyListView currentStudy) {
    StudyMeetingSchedule currentMeetingSchedule =
        currentStudy.meetingSchedules.first;

    StudyListView study =
        studyList.firstWhere((element) => element.id == currentStudy.id);

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

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
