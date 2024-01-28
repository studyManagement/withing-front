import 'package:flutter/material.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/model/study/study_exception.dart';
import 'package:withing/service/study/study_service.dart';
import 'package:withing/views/study/study_exception_screen.dart';

import '../../common/requester/network_exception.dart';
import '../../model/study/notice_model.dart';
import '../../model/study/study_meeting_schedules_model.dart';

class StudyViewModel extends ChangeNotifier {
  bool _disposed = false;
  final StudyService _service;
  List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];

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
        getRegularMeetingString(study.meetingSchedules);
        await fetchBoards(studyId, true);
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

  void getRegularMeetingString(
      List<StudyMeetingSchedulesModel> meetingSchedules) {
    int cnt = 0;
    if(meetingSchedules.isEmpty || meetingSchedules==null){
      regularMeeting = '미등록';
    }
    else if (meetingSchedules.length == 7) {
      regularMeeting = '매일 ${meetingSchedules[0].startTime}';
    }
    else{
      regularMeeting = '매주 ';
      for (int i = 0; i < meetingSchedules.length; i++) {
        if (cnt < meetingSchedules.length) {
          regularMeeting =
          '$regularMeeting${_weekString[meetingSchedules[i].day]}, ';
          cnt++;
        } else {
          regularMeeting =
          '$regularMeeting${_weekString[meetingSchedules[i].day]}';
        }
    }
    }
  }

  void navigateToStudyExceptionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudyExceptionScreen()),
    );
  }

  Future<void> fetchBoards(int studyId, bool isNotice) async {
    if (notices.isEmpty) {
      try {
        notices = await _service.fetchBoards(studyId, isNotice);
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
}
