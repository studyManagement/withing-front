import 'package:withing/model/study/study_list_model.dart';
import 'package:withing/view_models/study/model/study_meeting_schedule.dart';

class StudyListView {
  int id;
  String studyName;
  int max;
  int headcount;
  bool private;
  String explanation;
  DateTime createdAt;
  DateTime deadline;
  List<String> categories;
  List<StudyMeetingSchedule> meetingSchedules;

  StudyListView(
      this.id,
      this.studyName,
      this.max,
      this.headcount,
      this.private,
      this.explanation,
      this.createdAt,
      this.deadline,
      this.categories,
      this.meetingSchedules);

  factory StudyListView.from(StudyListModel model) {
    return StudyListView(
      model.id,
      model.studyName,
      model.max,
      model.headcount,
      model.private,
      model.explanation,
      model.createdAt,
      model.deadline,
      model.categories,
      model.meetingSchedules.map((e) => StudyMeetingSchedule.from(e)).toList(),
    );
  }

  StudyListView clone(List<StudyMeetingSchedule> meetingSchedules) {
    return StudyListView(
      id,
      studyName,
      max,
      headcount,
      private,
      explanation,
      createdAt,
      deadline,
      categories,
      meetingSchedules,
    );
  }

  List<StudyListView> spread() {
    if (meetingSchedules.length == 1) {
      return [this];
    }

    return meetingSchedules.map((e) => clone([e])).toList();
  }

  bool hasStudies(DateTime selectedDate) {
    int weekday = selectedDate.weekday;
    return meetingSchedules.where((e) => e.day == weekday).isNotEmpty;
  }

  StudyMeetingSchedule getPromise(DateTime selectedDate) {
    int weekday = selectedDate.weekday;
    StudyMeetingSchedule meetingSchedule =
        meetingSchedules.where((element) => element.day == weekday).first;
    return meetingSchedule;
  }

  @override
  String toString() {
    return "StudyListView(studyId=$id,studyName=$studyName,max=$max,headcount=$headcount,explanation=$explanation,categories=$categories,meetingSchedules=$meetingSchedules)";
  }
}
