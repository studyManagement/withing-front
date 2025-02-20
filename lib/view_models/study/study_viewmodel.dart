import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/logger/app_event.dart';
import 'package:modi/service/study/MeetingType.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:modi/views/common/study_error_page.dart';
import '../../common/components/bottom_toast.dart';
import '../../common/logger/logging_interface.dart';
import '../../common/modal/modi_modal.dart';
import '../../common/requester/api_exception.dart';
import '../../di/injection.dart';
import '../../model/board/board_model.dart';
import '../../model/study/study_list_model.dart';
import '../../model/user/user_model.dart';
import 'model/study_view.dart';

class StudyViewModel extends ChangeNotifier {
  bool _disposed = false;
  final StudyService _service;
  final BuildContext _context;

  static final LoggingInterface _logger = getIt<LoggingInterface>();

  StudyView? _study;
  List<UserModel> _users = [];

  final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];
  MeetingType? _meetingType;
  String regularMeetingStr = '';
  List<int> selectedDays = [];
  final List<int> _selectedUsers = [];
  String startTime = '미등록';
  String endTime = '미등록';
  late DateTime startAt;
  late DateTime endAt;

  String _password = '';
  List<bool> _isFilled = [for (int i = 0; i < 4; i++) false];
  bool _isInit = true; // 미등록인 경우에만 false
  int _newLeaderId = 0;
  bool _isOut = false;
  bool _isSwitched = false;
  bool _isMember = true;

  bool _isValidPwd = false;
  bool _isChecked = false;
  bool _successToJoin = false;
  bool _isFull = false;
  bool _isErrorText = false;
  bool _isAfter = true;
  bool _hasLike = false;
  bool hasPost = false;
  bool isLoading = true;
  int numOfPosts = 0;
  List<BoardModel> posts = [];

  int? _userId;
  static int leaderId = 0;
  static int studyMembers = 0;

  StudyView? get study => _study;

  List<UserModel> get users => _users;

  List<int> get selectedUsers => _selectedUsers;

  MeetingType get meetingType => _meetingType!;

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

  StudyViewModel(this._context, this._service);

  set meetingType(MeetingType type) {
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

  setStartAt(DateTime start) {
    startAt = start;
  }

  setEndAt(DateTime end) {
    endAt = end;
  }

  void updateSelectedUsers(int selectedUserId, int maxCount) {
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
    _isValidPwd = false;
    _isErrorText = false;
    _isChecked = false;
    _successToJoin = false;
    _password = '';
    _isFilled = [for (int i = 0; i < 4; i++) false];
  }

  Future<void> fetchStudyInfo(int studyId) async {
    if (_study == null) {
      try {
        _study = StudyView.from(await _service.fetchStudyInfo(studyId));
        isLoading = false;
        leaderId = _study!.leaderId;
        studyMembers = study!.users.length;
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
      } on ApiException catch (e) {
        if (!_context.mounted) return;
        ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
            () => _context.pop(), () => null);
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
    } on ApiException catch (e) {
      if (e.code == 400) {
        _isErrorText = true;
        _successToJoin = false;
        _isFull = true;
      } else if (e.code == 404) {
        if (!_context.mounted) return;
        ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
            () => _context.pop(), () => null);
      }
    }
    _isChecked = true;
    notifyListeners();
  }

  Future<void> pickFavoriteStudy() async {
    try {
      await _service.pickFavoriteStudy(_study!.id);
      _hasLike = true;
      notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  Future<void> cancelFavoriteStudy() async {
    try {
      await _service.cancelFavoriteStudy(_study!.id);
      _hasLike = false;
      notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  /// Admin Study
  Future<void> finishStudy() async {
    try {
      await _service.finishStudy(_study!.id);
      BottomToast(context: _context, text: "스터디가 종료되었어요.").show();
      if(!_context.mounted) return;
      _context.go('/search');
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => {_context.pop(), _context.pop()}, () => null);
    }
    notifyListeners();
  }

  Future<void> deleteStudy() async {
    try {
      await _service.deleteStudy(_study!.id);
      BottomToast(context: _context, text: "스터디가 삭제되었어요.").show();
      if(!_context.mounted) return;
      _context.go('/search');
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => {_context.pop(), _context.pop()}, () => null);
    }
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
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
    notifyListeners();
  }

  Future<void> forceToExitMember(int studyId) async {
    try {
      await _service.forceToExitMember(studyId, _selectedUsers);
      _isOut = true;
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
    notifyListeners();
  }

  Future<void> setMeetingSchedule(MeetingType type) async {
    try {
      List<StudyMeetingSchedule> _meetingSchedules = [];
      _meetingType = type;

      if (checkDaysAndTimes(type)) {
        if (_meetingType != MeetingType.NONE) {
          _isAfter = startAt.isAfter(endAt);
          String startTime24 = DateFormat('HH:mm').format(startAt);
          String endTime24 = DateFormat('HH:mm').format(endAt);
          if (_meetingType == MeetingType.DAILY) {
            _meetingSchedules.addAll(List.generate(
              7, (index) => StudyMeetingSchedule.withoutId(
                  index + 1, startTime24, endTime24),
            ));
          } else if (_meetingType == MeetingType.WEEKLY) {
            _meetingSchedules.addAll(
                selectedDays.map((day) => StudyMeetingSchedule.withoutId(day, startTime24, endTime24)).toList()
            );
          }
        } else {
          _meetingSchedules = [];
        }
        if ((_meetingType != MeetingType.NONE && !_isAfter) ||
            _meetingType == MeetingType.NONE) {
          await _service.setMeetingSchedule(study!.id, _meetingSchedules);
          if (!_context.mounted) return;
          _context.go('/studies/${study!.id}',extra: true);
        } else {
          if (!_context.mounted) return;
          ModiModal.openDialog(
              _context,
              '오류가 발생했어요',
              '시작 시간이 종료 시간보다 늦을 수 없어요.',
              false,
              () => _context.pop(),
              () => null);
          return;
        }
      }
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  /// utils
  void renderObscuringChar(String input) {
    _password = input;
    _isErrorText = false;
    _isValidPwd = RegExp(r'^\d{4}$').hasMatch(_password);
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
    ];
    if (!successToJoin && _isChecked && _isErrorText) {
      return errorText[1];
    } else {
      return errorText[0];
    }
  }

  bool checkDaysAndTimes(MeetingType type) {
    if (type == MeetingType.WEEKLY) {
      if (selectedDays.isNotEmpty && selectedDays.length <= 3) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  void getRegularMeetingStringAndSetMeetingType() {
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
      if (start.hour == 0) start.add(const Duration(hours: 12));

      String time = (start.hour > 0 && start.hour < 12)
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
    if (_meetingType == MeetingType.NONE) {
      startAt = DateTime.now();
      endAt = DateTime.now();
      return;
    } else {
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
      startAt =
          DateFormat('HH:mm').parse(_study!.meetingSchedules[0].startTime);
      startTime = DateFormat('a hh:mm', 'ko').format(startAt);
    }
    if (_study!.meetingSchedules.isNotEmpty &&
        _study!.meetingSchedules[0].endTime.trim().isNotEmpty) {
      endAt = DateFormat('HH:mm').parse(_study!.meetingSchedules[0].endTime);
      endTime = DateFormat('a hh:mm', 'ko').format(endAt);
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

  void initDaysAndTime(MeetingType type) {
    _meetingType = type;
    _isInit = true;
    selectedDays = [];
    startTime = '미등록';
    endTime = '미등록';
    notifyListeners();
  }

  void initMeetingSchedule(MeetingType type) {
    initDaysAndTime(type);
    _meetingType = type;
    notifyListeners();
  }

  void checkRegistered() {
    // 스터디 가입 여부
    _isMember = users.any((user) => user.id == _userId);
  }

  void navigateToStudyErrorPage() {
    Navigator.push(
      _context,
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
