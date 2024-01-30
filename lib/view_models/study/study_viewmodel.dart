import 'package:flutter/material.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/model/study/study_exception.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/views/study/study_exception_screen.dart';
import '../../common/requester/network_exception.dart';
import '../../model/board/board_model.dart';
import '../../model/study/study_meeting_schedules_model.dart';
import '../../model/user/user_model.dart';

class StudyViewModel extends ChangeNotifier {
  bool _disposed = false;
  final StudyService _service;
  final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];

  var study;
  List<int> days = [];
  String regularMeeting = '';
  String startTime = '';
  int newLeaderId = 0;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  bool hasPost = false;
  int numOfPosts = 0;
  List<BoardModel> posts = [];

  StudyViewModel(this._service);

  Future<void> fetchStudyInfo(BuildContext context, int studyId) async {
    if (study == null) {
      try {
        study = await _service.fetchStudyInfo(studyId);
        _users = study.users;
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


  Future<void> fetchBoards(int studyId, bool isNotice) async {
    if (posts.isEmpty) {
      try {
        posts = await _service.fetchBoards(studyId, isNotice);
        if (posts.isNotEmpty) {
          hasPost = true;
          numOfPosts = posts.length;
        }
      } on ApiException catch (e) {
        if (e.code == 404) {
          // 공지사항이 없는 경우 처리
          hasPost = false;
          numOfPosts = 0;
        }
      }
      notifyListeners();
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
    List<int> days = [];
    for(int i = 0;i<meetingSchedules.length;i++) {
      if (!days.contains(meetingSchedules[i].day)) {
        days.add(meetingSchedules[i].day);
      }
    }
    if(days.isEmpty){
      regularMeeting = '미등록';
    }
    else if(days.length==7){
      regularMeeting = '매일 ${meetingSchedules[0].startTime}';
    } else {
      regularMeeting = '매주 ';
        for (int i = 0; i < days.length; i++) {
          if (cnt < days.length-1) {
            regularMeeting =
            '$regularMeeting${_weekString[days[i]]}, ';
            cnt++;
          } else {
            regularMeeting =
            '$regularMeeting${_weekString[days[i]]}';
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
