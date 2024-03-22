import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/logger/app_event.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/model/study/study_exception.dart';
import 'package:modi/service/study/MeetingType.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:modi/views/common/study_error_page.dart';
import '../../common/logger/logging_interface.dart';
import '../../di/injection.dart';
import '../../model/board/board_model.dart';
import '../../model/study/study_list_model.dart';
import '../../model/user/user_model.dart';
import 'model/study_view.dart';

class StudyViewModel extends ChangeNotifier {
  bool _disposed = false;
  final StudyService _service;

  static final LoggingInterface _logger = getIt<LoggingInterface>();

  StudyView? _study;
  List<UserModel> _users = [];

  final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];
  MeetingType? _meetingType;
  String regularMeetingStr = '';
  List<int> selectedDays = [];
  List<int> _selectedUsers = [];
  String startTime = '미등록';
  String endTime = '미등록';
  String _password = '';
  List<bool> _isFilled = [for (int i = 0; i < 4; i++) false];
  bool _isInit = true; // 미등록인 경우에만 false
  int _newLeaderId = 0;
  bool _isOut = false;
  bool _isSwitched = false;
  bool _isMember = true;

  bool _isValidPwd = true;
  bool _isChecked = false;
  bool _successToJoin = false;
  bool _isFull = false;
  bool _isErrorText = false;

  bool _hasLike = false;
  bool hasPost = false;
  int numOfPosts = 0;
  List<BoardModel> posts = [];

  int? _userId;

  StudyView? get study => _study;

  List<UserModel> get users => _users;

  List<int> get selectedUsers => _selectedUsers;

  MeetingType get meetingType => _meetingType!;

  bool get isInit => _isInit;

  String get password => _password;

  List<bool> get isFilled => _isFilled;

  bool get isValidPwd => _isValidPwd;

  bool get isChecked => _isChecked;

  bool get successToJoin => _successToJoin;

  bool get isFull => _isFull;

  bool get isErrorText => _isErrorText;

  int get newLeaderId => _newLeaderId;

  bool get isMember => _isMember;

  bool get isOut => _isOut;

  bool get isSwitched => _isSwitched;

  bool get hasLike => _hasLike;

  StudyViewModel(this._service);

  set meetingType(MeetingType type) {
    initDaysAndTime(type);
    _meetingType = type;
    notifyListeners();
  }

  set userId(int id) {
    _userId = id;
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  void updateSelectedUsers(int selectedUserId, int maxCount){
    if (_selectedUsers.contains(selectedUserId)) {
      _selectedUsers.remove(selectedUserId);
    } else {
      if (_selectedUsers.length >= maxCount) {
        _selectedUsers.clear();
      }
      _selectedUsers.add(selectedUserId);
    }
    notifyListeners();
  }

  void initPasswordProperties() {
    _isValidPwd = true;
    _isErrorText = false;
    _isChecked = false;
    _successToJoin = false;
    _password = '';
    _isFilled = [for (int i = 0; i < 4; i++) false];
  }

  Future<void> fetchStudyInfo(BuildContext context, int studyId) async {
    if (_study == null) {
      try {
        _study = StudyView.from(await _service.fetchStudyInfo(studyId));
        _users = _study!.users;
        checkRegistered();
        if (!_isMember) {
          List<StudyListModel> myPickStudies =
              await _service.fetchMyStudies(StudyType.LIKE);
          for (var study in myPickStudies) {
            if (study.id == _study!.id) {
              _hasLike = true;
            }
          }
        }
        notifyListeners();
      } on StudyException catch (e) {
        // 스터디가 없는 경우
        if (!context.mounted) return;
        navigateToStudyErrorPage(context);
      }
    }
  }

  Future<void> isValidPassword() async {
    _isValidPwd = RegExp(r'^\d{4}$').hasMatch(_password);
    if (_isValidPwd) {
      await joinStudy(_password);
    }
    _password = '';
    _isChecked = _isValidPwd;
    _isFilled = [for (int i = 0; i < 4; i++) false];
    notifyListeners();
  }

  Future<void> joinStudy(String? password) async {
    try {
      var response = await _service.joinStudy(study!.id, password);
      _logger.appEvent(
        AppEvent.JOIN_GROUP,
        method: 'Join study',
        groupId: study!.id.toString(),
      );
      if (response != null) _successToJoin = true;
    } on StudyException catch (e) {
      if (e.code == 400) {
        _successToJoin = false;
        _isFull = true;
      }
    }
    _isChecked = true;
    notifyListeners();
  }

  Future<void> pickFavoriteStudy() async {
    await _service.pickFavoriteStudy(_study!.id);
    _hasLike = true;
    notifyListeners();
  }

  Future<void> cancelFavoriteStudy() async {
    await _service.cancelFavoriteStudy(_study!.id);
    _hasLike = false;
    notifyListeners();
  }

  /// Admin Study
  Future<void> finishStudy() async {
    await _service.finishStudy(_study!.id);
    notifyListeners();
  }

  Future<void> deleteStudy() async {
    await _service.deleteStudy(_study!.id);
    notifyListeners();
  }

  Future<void> switchLeader(int studyId) async {
    try {
      final studyModel = await _service.switchLeader(studyId, selectedUsers[0]);
      _newLeaderId = studyModel.leaderId;
      _isSwitched = true;
    } on ApiException catch (e) {
      // 변경 실패
      _isSwitched = false;
    }
    notifyListeners();
  }

  Future<void> forceToExitMember(int studyId) async {
    try {
      await _service.forceToExitMember(studyId, _selectedUsers);
      _isOut = true;
    } on ApiException catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> setMeetingSchedule(MeetingType type) async {
    List<StudyMeetingSchedule> _meetingSchedules = [];
    _meetingType = type;

    if (checkDaysAndTimes(type)) {
      if (_meetingType != MeetingType.NONE) {
        DateTime start = DateFormat('hh:mm')
            .parse(startTime.substring(3, 8)); // 입력된 시간 포맷을 해석합니다.
        DateTime end = DateFormat('hh:mm')
            .parse(endTime.substring(3, 8)); // 입력된 시간 포맷을 해석합니다.
        if (startTime.contains('오후')) {
          start = start.add(const Duration(hours: 12));
        }
        if (endTime.contains('오후')) {
          end = end.add(const Duration(hours: 12));
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
            _meetingSchedules.add(
                StudyMeetingSchedule.withoutId(day, startTime24, endTime24));
          }
        }
      }
      await _service.setMeetingSchedule(study!.id, _meetingSchedules);
    }
  }

  /// utils
  void renderObscuringChar(String input) {
    _password = input;
    for (int i = 1; i <= 4; i++) {
      if (i <= _password.length) {
        _isFilled[i - 1] = true;
      } else {
        _isFilled[i - 1] = false;
      }
    }
    notifyListeners();
  }

  String getPasswordErrorText() {
    List<String> errorText = [
      '스터디 가입을 위해 필요해요.',
      '잘못된 비밀번호에요.',
      '올바른 형식이 아니에요.'
    ];

    if (!successToJoin && _isChecked) {
      _isErrorText = true;
      return errorText[1];
    } else if (!_isChecked && !_isValidPwd && !successToJoin) {
      _isErrorText = true;
      return errorText[2];
    } else {
      _isErrorText = false;
      return errorText[0];
    }
  }

  bool checkDaysAndTimes(MeetingType type) {
    if (type == MeetingType.DAILY) {
      if (startTime != '미등록' && endTime != '미등록') {
        return true;
      } else {
        return false;
      }
    } else if (type == MeetingType.WEEKLY) {
      if (selectedDays.isNotEmpty &&
          selectedDays.length <= 3 &&
          startTime != '미등록' &&
          endTime != '미등록') {
        return true;
      } else {
        return false;
      }
    } else {
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
    days.sort();

    if (days.isEmpty) {
      regularMeetingStr = '비정기 모임';
      _meetingType = MeetingType.NONE;
      _isInit = false;
    } else {
      DateTime start =
          DateFormat('HH:mm').parse(_study!.meetingSchedules[0].startTime);
      String startMeridiem = (start.hour < 12) ? '오전' : '오후';
      String time = (start.hour < 12)
          ? _study!.meetingSchedules[0].startTime
          : DateFormat('hh:mm').format(start);
      if (days.length == 7) {
        regularMeetingStr = '매일 $startMeridiem $time';
        _meetingType = MeetingType.DAILY;
      } else {
        regularMeetingStr = '매주 (';
        _meetingType = MeetingType.WEEKLY;
        for (int i = 0; i < days.length; i++) {
          if (cnt < days.length - 1) {
            regularMeetingStr =
                '$regularMeetingStr${_weekString[days[i] - 1]}, ';
            cnt++;
          } else {
            regularMeetingStr =
                '$regularMeetingStr${_weekString[days[i] - 1]})';
          }
        }
        regularMeetingStr = '$regularMeetingStr $startMeridiem $time';
      }
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

  void checkRegistered() {
    // 스터디 가입 여부
    _isMember = users.any((user) => user.id == _userId);
  }

  void navigateToStudyErrorPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudyErrorPage()),
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
