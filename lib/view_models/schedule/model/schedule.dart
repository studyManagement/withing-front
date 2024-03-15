import 'package:modi/model/schedule/schedule_model.dart';

class Schedule {
  int id;
  String title;
  String description;
  DateTime startAt;
  DateTime endAt;

  Schedule(this.id, this.title, this.description, this.startAt, this.endAt);

  factory Schedule.from(ScheduleModel model) {
    return Schedule(
        model.id, model.title, model.description, model.startAt, model.endAt);
  }

  @override
  String toString() {
    return "ScheduleModel(id=$id,title=$title,description=$description,startAt=$startAt,endAt=$endAt)";
  }
}
