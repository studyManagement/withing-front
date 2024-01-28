import 'package:withing/model/study/study_meeting_schedules_model.dart';

final List<String> WeekString = ['월', '화', '수', '목', '금', '토', '일'];

class StudyMeetingSchedule {
  int id;
  int day;
  String startTime;
  String endTime;

  StudyMeetingSchedule(this.id, this.day, this.startTime, this.endTime);

  factory StudyMeetingSchedule.from(StudyMeetingSchedulesModel model) {
    return StudyMeetingSchedule(
        model.id, model.day, model.startTime, model.endTime);
  }

  @override
  String toString() {
    return "StudyMeetingSchedule(id=$id,day=$day,startTime=$startTime,endTime=$endTime)";
  }

/*
  DateTime getPromiseDays(DateTime selectedDay) {
    int weekday = selectedDay.weekday;
    List<int> days = this.days.where((element) => element > 0).toList();

    days.sort();

    int currentIndex = days.indexOf(weekday);

    List<DateTime> daysToDateTime = [];
    for (final i in days) {
      if (i == days[currentIndex]) {
        daysToDateTime.add(selectedDay);
      } else if (i > days[currentIndex]) {
        daysToDateTime
            .add(selectedDay.add(Duration(days: (i - days[currentIndex]))));
      } else if (i < days[currentIndex]) {
        daysToDateTime.add(selectedDay.add(Duration(days: i)));
      }
    }

    if (currentIndex + 1 == days.length) {
      return daysToDateTime[0];
    } else {
      return daysToDateTime[currentIndex + 1];
    }
  }

  String getNextWeek(DateTime selectedDay) {
    int weekday = selectedDay.weekday;
    List<int> days = this.days.where((element) => element > 0).toList();
    int currentIndex = days.indexOf(weekday);

    if (currentIndex + 1 == days.length) {
      return _weekString[days[0] - 1];
    } else {
      return _weekString[days[currentIndex + 1] - 1];
    }
  }

   */
}
