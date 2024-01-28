import 'package:flutter/material.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/model/study/study_exception.dart';
import 'package:withing/service/study/study_service.dart';
import 'package:withing/view_models/study/model/study_meeting_schedule.dart';
import 'package:withing/views/study/study_exception_screen.dart';

import '../../common/requester/network_exception.dart';
import '../../model/study/notice_model.dart';

class StudyViewModel extends ChangeNotifier {
  bool _disposed = false;
  final StudyService _service;

  var study;
  List<int> days = [];
  String regularMeeting = '';
  String startTime = '';
  int newLeaderId = 0;

  bool hasNotice = false;
  int numOfNotices = 0;
  List<NoticeModel> notices = [];

  StudyViewModel(this._service);

  Future<void> fetchStudyInfo(BuildContext context, int studyId) async {
    if (study == null) {
      try {
        study = await _service.fetchStudyInfo(studyId);
        if (study.days != null) days = study.days;
        if (study.startTime != null) startTime = study.startTime;
        await fetchNotices(studyId);
        notifyListeners();
      } on StudyException catch (e) {
        // 스터디가 없는 경우
        if (!context.mounted) return;
        navigateToStudyExceptionScreen(context);
      } on NetworkException catch (e) {
        print(e);
      }
    }
  }

  Future<void> finishStudy(int studyId) async {
    await _service.finishStudy(studyId);
    notifyListeners();
  }

  Future<void> deleteStudy(int studyId) async {
    await _service.deleteStudy(studyId);
    notifyListeners();
  }

  Future<void> switchLeader(int studyId, int userId) async {
    final studyModel = await _service.switchLeader(studyId, userId);
    newLeaderId = studyModel.leaderId;
    notifyListeners();
  }

  String getRegularMeetingString() {
    String regularMeeting = '';
    if (study.gap == 0 && startTime.length >= 5) {
      regularMeeting = '매일 ${startTime.substring(0, 5)}';
    } else if (study.gap == 1) {
      regularMeeting = '매주 ';
      int cnt = 0;
      for (int i = 0; i < days.length; i++) {
        if (cnt < days.length) {
          regularMeeting = '$regularMeeting${WeekString[days[i]]}, ';
          cnt++;
        } else {
          regularMeeting = '$regularMeeting${WeekString[days[i]]} ';
        }
      }
    } else {
      regularMeeting = '미등록';
    }
    return regularMeeting;
  }

  void navigateToStudyExceptionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudyExceptionScreen()),
    );
  }

  Future<void> fetchNotices(int studyId) async {
    if (notices.isEmpty) {
      try {
        notices = await _service.fetchNotices(studyId);
        if (notices.isNotEmpty) {
          hasNotice = true;
          numOfNotices = notices.length;
        }
      } on ApiException catch (e) {
        if (e.code == 404) {
          // 공지사항이 없는 경우 처리
          hasNotice = false;
          numOfNotices = 0;
        }
      }
      notifyListeners();
    }
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
