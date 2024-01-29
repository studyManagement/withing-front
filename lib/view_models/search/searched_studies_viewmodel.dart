import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../model/search/searched_study_info_model.dart';

abstract class SearchedStudiesViewModel {
  int get studiesCount;
  dynamic get selectedValue;
  String get filterValue;
  List<SearchedStudyInfo>? get studyList;
  Future<void> search();
  Future<void> scrollListener();
  void updateSearchFilterValue(String value);
}

/// utils
///
List<String> getStudyFilters() {
  return const ['최신순', '인기순'];
}

String getFilter(String value) {
  switch (value) {
    case '최신순':
      return 'created_at';
    case '인기순':
      return 'popularity';
    default:
      debugPrint('올바른 필터 형식이 아닙니다.');
      return '최신순';
  }
}

String stringifySchedule(List<MeetingInfo> meetings) {
  Map<int, String> dayNames = {
    1: '월요일',
    2: '화요일',
    3: '수요일',
    4: '목요일',
    5: '금요일',
    6: '토요일',
    7: '일요일'
  };

  DateFormat inputFormat = DateFormat('HH:mm');
  DateFormat outputFormat = DateFormat('h:mm');

  List<String> meetingStrings = [];

  for (var meeting in meetings) {
    DateTime startTime = inputFormat.parse(meeting.startTime);
    DateTime endTime = inputFormat.parse(meeting.endTime);

    String startPeriod = startTime.hour >= 12 ? '오후' : '오전';
    int startHour = startTime.hour >= 12 ? startTime.hour - 12 : startTime.hour;
    startHour = startHour == 0 ? 12 : startHour;

    String endPeriod = endTime.hour >= 12 ? '오후' : '오전';
    int endHour = endTime.hour >= 12 ? endTime.hour - 12 : endTime.hour;
    endHour = endHour == 0 ? 12 : endHour;

    String formattedStartTime = outputFormat.format(startTime);
    String formattedEndTime = outputFormat.format(endTime);

    // String meetingTime =
    //     '$startPeriod $formattedStartTime - $endPeriod $formattedEndTime';
    String meetingTime = '$startPeriod $formattedStartTime';
    String meetingDay = dayNames[meeting.day]!;

    // meetingStrings.isEmpty
    //     ? meetingStrings.add('매주 $meetingDay $meetingTime')
    //     : meetingStrings.add('        $meetingDay $meetingTime');

    meetingStrings.add('매주 $meetingDay $meetingTime');
  }

  return meetingStrings.join('\n');
}
