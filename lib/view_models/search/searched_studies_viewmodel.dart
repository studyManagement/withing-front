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
///

const int size = 10;

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
      return '최신순';
  }
}

String getRegularMeetingString(List<dynamic> meetingSchedules) {
  final List<String> _weekString = ['월', '화', '수', '목', '금', '토', '일'];
  int cnt = 0;
  List<int> days = [];
  String regularMeetingStr = '';

  for (int i = 0; i < meetingSchedules.length; i++) {
    if (!days.contains(meetingSchedules[i].day)) {
      days.add(meetingSchedules[i].day);
    }
  }
  days.sort();

  if (days.isEmpty) {
    regularMeetingStr = '비정기 모임';
  } else{
    DateTime start =
    DateFormat('HH:mm').parse(meetingSchedules[0].startTime);
    String startMeridiem = (start.hour < 12) ? '오전' : '오후';
    String time = (start.hour < 12)
        ? meetingSchedules[0].startTime
        : DateFormat('hh:mm').format(start);
    if (days.length == 7) {
      regularMeetingStr = '매일 $startMeridiem $time';
    } else {
      regularMeetingStr = '매주 (';
      for (int i = 0; i < days.length; i++) {
        if (cnt < days.length - 1) {
          regularMeetingStr = '$regularMeetingStr${_weekString[days[i] - 1]}, ';
          cnt++;
        } else {
          regularMeetingStr = '$regularMeetingStr${_weekString[days[i] - 1]})';
        }
      }
      regularMeetingStr =
      '$regularMeetingStr $startMeridiem $time';
    }
  }
  return regularMeetingStr;
}

