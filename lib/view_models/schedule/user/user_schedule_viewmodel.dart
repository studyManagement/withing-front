import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/exception/signin/user_not_found_exception.dart';
import 'package:modi/model/schedule/user_schedule_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:provider/provider.dart';

import '../../../common/modal/modi_modal.dart';

class UserScheduleViewModel extends ChangeNotifier {
  final ScheduleService _scheduleService;

  UserScheduleViewModel(this._scheduleService);

  final int SIZE = 10;
  int entireLength = 0;
  bool _isLoading = false;
  bool isFetching = true;
  String headerString = '';
  String dateParamString = '';
  List<UserScheduleModel> userScheduleList = [];
  List<List<UserScheduleModel>> _scheduleListSplitByDate = [];
  List<List<UserScheduleModel>> get scheduleListSplitByDate => _scheduleListSplitByDate;
  final String todayDate =
      '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';

  final String titleDateString =
      '${DateTime.now().year}년 ${DateTime.now().month}월';

  Future<void> scrollListener(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;

    await fetchUserSchedule(context);
    _isLoading = false;
  }

  Future<void> fetchUserSchedule(BuildContext context) async { // 데이터 길이 제한 없음
    List<UserScheduleModel> newScheduleList = [];
    try {
      dateParamString = (userScheduleList.isEmpty)
          ? todayDate
          : DateFormat('yyyy-MM-dd').format(
              DateTime.parse(userScheduleList.last.date)
                  .add(const Duration(days: 1)));
      newScheduleList =
          await _scheduleService.fetchUserSchedule(dateParamString, SIZE);
      if(newScheduleList.isNotEmpty){
        userScheduleList.addAll(newScheduleList);
        entireLength = userScheduleList.length;
        _scheduleListSplitByDate = _splitListByDate(); // split by date
        notifyListeners();
      }
      isFetching = false;
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(
        context,
        '오류가 발생했어요',
        e.cause,
        false,
        () => context.pop(),
        () => null,
      );
    }
  }

  List<List<UserScheduleModel>> _splitListByDate() {
    List<List<UserScheduleModel>> scheduleListSplitByDate = [];
    List<UserScheduleModel> currentSublist = [userScheduleList[0]];
    for (int i = 1; i < userScheduleList.length; i++) {
      if (userScheduleList[i].date != currentSublist.last.date) {
        if (currentSublist.isNotEmpty) {
          scheduleListSplitByDate.add(currentSublist);
        }
        currentSublist = [];
      }
      currentSublist.add(userScheduleList[i]);
    }
    if (currentSublist.isNotEmpty) {
      scheduleListSplitByDate.add(currentSublist);
    }
    return scheduleListSplitByDate;
  }

  getHeaderString(String date) {
    final parseDateTime = DateTime.parse(date);
    headerString =
        '${parseDateTime.month}월 ${parseDateTime.day}일 ${DateFormat('E', 'ko_KR').format(parseDateTime)}요일';
  }

  String get12hourString(String time){
    String result = '';
    DateTime start = DateFormat('HH:mm').parse(time);
    String startMeridiem = (start.hour < 12) ? '오전 ' : '오후 ';
    result = startMeridiem;
    if(start.hour == 0) start.add(const Duration(hours: 12));
    result += (start.hour > 0 && start.hour < 12)
        ? time
        : DateFormat('hh:mm').format(start);

    return result;
  }
}
