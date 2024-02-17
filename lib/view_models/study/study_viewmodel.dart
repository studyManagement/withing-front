
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/model/study/study_exception.dart';
import 'package:modi/service/study/MeetingType.dart';
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

  StudyView? _study;
  List<UserModel> _users = [];

  final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];
  MeetingType? _meetingType;
  String regularMeetingStr = '';
  List<int> selectedDays = [];
  String startTime = '미등록';
  String endTime = '미등록';
  bool _isInit = true; // 미등록인 경우에만 false
  int _newLeaderId = 0;
  bool _isOut = false;
  bool _isSwitched = false;
  bool _isMember = false;
  bool _checkPwd = true;
  bool _successToJoin = false;

  bool hasPost = false;
  int numOfPosts = 0;
  List<BoardModel> posts = [];

  StudyView? get study => _study;

  List<UserModel> get users => _users;

  MeetingType get meetingType => _meetingType!;

  bool get isInit => _isInit;

  bool get checkPwd => _checkPwd;

  bool get successToJoin => _successToJoin;

  int get newLeaderId => _newLeaderId;

  bool get isMember => _isMember;

  bool get isOut => _isOut;

  bool get isSwitched => _isSwitched;

  StudyViewModel(this._service);

  Future<void> fetchStudyInfo(BuildContext context, int studyId) async {
    if (_study == null) {
      try {
        _study = StudyView.from(await _service.fetchStudyInfo(studyId));
        _users = _study!.users;
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

  Future<void> finishStudy() async {
    await _service.finishStudy(_study!.id);
    notifyListeners();
  }

  Future<void> deleteStudy() async {
    await _service.deleteStudy(_study!.id);
    notifyListeners();
  }

  Future<void> switchLeader(int userId) async {
    try {
      final studyModel = await _service.switchLeader(_study!.id, userId);
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

  Future<void> joinStudy(int studyId, String? password) async {
    try {
      await _service.joinStudy(studyId, password);
      _successToJoin = true;
    } on StudyException catch (e) {
      if (e.code == 400) {
        // 비밀번호 오류
        _checkPwd = false;
      }
    }
    notifyListeners();
  }

  Future<void> setMeetingSchedule(MeetingType type) async {
    List<StudyMeetingSchedule> _meetingSchedules = [];
    _meetingType = type;

    if (checkDaysAndTimes(type)) {
      if(_meetingType != MeetingType.NONE) {
        DateTime start = DateFormat('hh:mm')
            .parse(startTime.substring(3, 8)); // 입력된 시간 포맷을 해석합니다.
        DateTime end = DateFormat('hh:mm')
            .parse(endTime.substring(3, 8)); // 입력된 시간 포맷을 해석합니다.
        if (startTime.contains('오후')) {
          start = start.add(Duration(hours: 12));
        }
        if (endTime.contains('오후')) {
          end = end.add(Duration(hours: 12));
        }
        String startTime24 = DateFormat('HH:mm').format(start);
        String endTime24 = DateFormat('HH:mm').format(end);
        if (_meetingType == MeetingType.DAILY) {
          for (int i = 1; i <= 7; i++) {
            _meetingSchedules
                .add(StudyMeetingSchedule.withoutId(i, startTime24, endTime24));
          }
        } else if (_meetingType == MeetingType.WEEKLY) {
          for (var day in selectedDays) {
            _meetingSchedules
                .add(
                StudyMeetingSchedule.withoutId(day, startTime24, endTime24));
          }
        }
      }
      await _service.setMeetingSchedule(study!.id, _meetingSchedules);
    }
  }

  set meetingType(MeetingType type) {
    initDaysAndTime(type);
    _meetingType = type;
    notifyListeners();
  }

  bool checkDaysAndTimes(MeetingType type) {
    if (type == MeetingType.DAILY) {
      if (startTime != '미등록' && endTime != '미등록') {
        return true;
      } else {
        print('입력 조건 미충족');
        return false;
      }

    } else if(type == MeetingType.WEEKLY){
      if (selectedDays.isNotEmpty && selectedDays.length <= 3 && startTime != '미등록' && endTime != '미등록') {
        return true;
      } else {
        print('입력 조건 미충족');
        return false;
      }
    }
    else{
      return true;
    }
  }

  void getRegularMeetingString() {
    int cnt = 0;
    List<int> days = [];
    for (int i = 0; i < _study!.meetingSchedules.length; i++) {
      if (!days.contains(_study!.meetingSchedules[i].day)) {
        days.add(_study!.meetingSchedules[i].day);
      }
    }
    if (days.isEmpty) {
      regularMeetingStr = '미등록';
      _meetingType = MeetingType.NONE;
      _isInit = false;
    } else if (days.length == 7) {
      regularMeetingStr = '매일 ${_study!.meetingSchedules[0].startTime}';
      _meetingType = MeetingType.DAILY;
    } else {
      regularMeetingStr = '매주 ';
      _meetingType = MeetingType.WEEKLY;
      for (int i = 0; i < days.length; i++) {
        if (cnt < days.length - 1) {
          regularMeetingStr = '$regularMeetingStr${_weekString[days[i] - 1]}, ';
          cnt++;
        } else {
          regularMeetingStr = '$regularMeetingStr${_weekString[days[i] - 1]}';
        }
      }
      regularMeetingStr =
          '$regularMeetingStr ${_study!.meetingSchedules[0].startTime}';
    }
  }

  void getSelectedDaysAndTime() {
    if (_meetingType != MeetingType.NONE) {
      List<int> days = [];
      for (int i = 0; i < _study!.meetingSchedules.length; i++) {
        if (!days.contains(_study!.meetingSchedules[i].day)) {
          days.add(_study!.meetingSchedules[i].day);
          days.sort();
        }
      }
      selectedDays = days;
    }
    if (_study!.meetingSchedules.isNotEmpty &&
        _study!.meetingSchedules[0].startTime.trim().isNotEmpty) {
      DateTime start =
          DateFormat('HH:mm').parse(_study!.meetingSchedules[0].startTime);
      String startMeridiem = (start.hour < 12) ? '오전' : '오후';
      String time = (start.hour < 12)
          ? _study!.meetingSchedules[0].startTime
          : DateFormat('hh:mm').format(start);
      startTime = '$startMeridiem $time';
    }
    if (_study!.meetingSchedules.isNotEmpty &&
        _study!.meetingSchedules[0].endTime.trim().isNotEmpty) {
      DateTime end =
          DateFormat('HH:mm').parse(_study!.meetingSchedules[0].endTime);
      String endMeridiem = (end.hour < 12) ? '오전' : '오후';
      String time = (end.hour < 12)
          ? _study!.meetingSchedules[0].startTime
          : DateFormat('hh:mm').format(end);
      endTime = '$endMeridiem $time';
    }
  }

  void setMeetingDays(int value, MeetingType type) {
    _meetingType = type;
    //  print(meetingType);
    if (!selectedDays.contains(value) && selectedDays.length < 3) {
      selectedDays.add(value);
    } else if (selectedDays.contains(value)) {
      // 이미 선택된 요일인 경우 제거
      selectedDays.remove(value);
    }
    selectedDays.sort();
    notifyListeners();
  }

  void setMeetingTime(bool isStart, DateTime time, MeetingType type) {
    _meetingType = type;
    if (isStart) {
      String startMeridiem = (time.hour < 12) ? '오전' : '오후';
      startTime = (time.hour < 12)
          ? DateFormat('HH:mm').format(time)
          : DateFormat('hh:mm').format(time);
      startTime = '$startMeridiem $startTime';
    } else {
      String endMeridiem = (time.hour < 12) ? '오전' : '오후';
      endTime = (time.hour < 12)
          ? DateFormat('HH:mm').format(time)
          : DateFormat('hh:mm').format(time);
      endTime = '$endMeridiem $endTime';
    }
    notifyListeners();
  }

  void initDaysAndTime(MeetingType type) {
    _meetingType = type;
    _isInit = true;
    selectedDays = [];
    startTime = '미등록';
    endTime = '미등록';
    notifyListeners();
  }

  void checkRegistered(List<UserModel> users, int userId) {
    // 스터디 가입 여부 확인
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
