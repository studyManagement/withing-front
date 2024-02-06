import 'package:flutter/material.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/model/study/study_exception.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:modi/views/study/study_exception_screen.dart';
import '../../common/requester/network_exception.dart';
import '../../model/board/board_model.dart';
import '../../model/user/user_model.dart';
import 'model/study_view.dart';

class StudyViewModel extends ChangeNotifier {
  bool _disposed = false;
  final StudyService _service;

  final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];

  StudyView? _study;

  StudyView? get study => _study;

  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  String regularMeeting = '';
  String startTime = '';

  int _newLeaderId = 0;
  bool _isOut = false;
  bool _isSwitched = false;
  bool _isMember = false;

  int get newLeaderId => _newLeaderId;

  bool get isMember => _isMember;

  bool get isOut => _isOut;

  bool get isSwitched => _isSwitched;

  bool hasPost = false;
  int numOfPosts = 0;
  List<BoardModel> posts = [];

  StudyViewModel(this._service);

  Future<void> fetchStudyInfo(BuildContext context, int studyId) async {
    if (_study == null) {
      try {
        _study = StudyView.from(await _service.fetchStudyInfo(studyId));
        _users = _study!.users;
        getRegularMeetingString(_study!.meetingSchedules);
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
          notifyListeners();
        }
      } on ApiException catch (e) {
        if (e.code == 404) {
          // 공지사항이 없는 경우 처리
          hasPost = false;
          numOfPosts = 0;
        }

        if (e.code == 400) {
          // 접근 권한 x
        }
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
    try {
      final studyModel = await _service.switchLeader(studyId, userId);
      _newLeaderId = studyModel.leaderId;
      _isSwitched = true;
    } on ApiException catch (e) {
      // 변경 실패

      _isSwitched = false;
    }
    notifyListeners();
  }

  Future<void> forceToExitMember(int studyId, List<int> users) async {
    try {
      var response = await _service.forceToExitMember(studyId, users);
      print(response.data);
      _isOut = true;
    } on ApiException catch (e) {
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  void getRegularMeetingString(List<StudyMeetingSchedule> meetingSchedules) {
    int cnt = 0;
    List<int> days = [];
    for (int i = 0; i < meetingSchedules.length; i++) {
      if (!days.contains(meetingSchedules[i].day)) {
        days.add(meetingSchedules[i].day);
      }
    }
    if (days.isEmpty) {
      regularMeeting = '미등록';
    } else if (days.length == 7) {
      regularMeeting = '매일 ${meetingSchedules[0].startTime}';
    } else {
      regularMeeting = '매주 ';
      for (int i = 0; i < days.length; i++) {
        if (cnt < days.length - 1) {
          regularMeeting = '$regularMeeting${_weekString[days[i]]}, ';
          cnt++;
        } else {
          regularMeeting = '$regularMeeting${_weekString[days[i]]}';
        }
      }
    }
  }

  void checkRegistered(List<UserModel> users, int userId) { // 스터디 가입 여부 확인
    _isMember = users.any((user) => user.id == userId);
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
