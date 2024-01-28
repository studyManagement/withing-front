import 'package:withing/model/study/study_model.dart';
import 'package:withing/model/user/user_model.dart';
import 'package:withing/view_models/study/model/study_meeting_schedule.dart';

class StudyView {
  int id;
  String studyName;
  int max;
  int headcount;
  bool private;
  bool finished;
  String explanation;
  int leaderId;
  DateTime createdAt;
  DateTime deadline;
  String? studyImage;
  List<String> categories;
  List<StudyMeetingSchedule> meetingSchedules;
  List<UserModel> users;

  StudyView(
      this.id,
      this.studyName,
      this.max,
      this.headcount,
      this.private,
      this.finished,
      this.explanation,
      this.leaderId,
      this.createdAt,
      this.deadline,
      this.studyImage,
      this.categories,
      this.meetingSchedules,
      this.users);

  factory StudyView.from(StudyModel model) {
    return StudyView(
      model.id,
      model.studyName,
      model.max,
      model.headcount,
      model.private,
      model.finished,
      model.explanation,
      model.leaderId,
      model.createdAt,
      model.deadline,
      model.studyImage,
      model.categories,
      model.meetingSchedules.map((e) => StudyMeetingSchedule.from(e)).toList(),
      model.users,
    );
  }

  /*
  String getNextDay(DateTime selectedDay) {
    final nextDay = regularMeetings.first.getPromiseDays(selectedDay);
    final DateFormat formatter = DateFormat('yyyy.MM.dd');
    return formatter.format(nextDay);
  }

  String getNextWeek(DateTime selectedDay) {
    return regularMeetings.first.getNextWeek(selectedDay);
  }

  bool hasSelectedDay(DateTime selectedDay) {
    return regularMeetings
        .where((element) => element.hasSelectedDay(selectedDay))
        .isNotEmpty;
  }
   */

  @override
  String toString() {
    return "StudyView(studyId=$id,studyName=$studyName,max=$max,headcount=$headcount,explanation=$explanation,leaderId=$leaderId,studyImage=$studyImage,categories=$categories,meetingSchedules=$meetingSchedules)";
  }
}
