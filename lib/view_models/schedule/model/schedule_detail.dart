import 'package:modi/model/schedule/schedule_detail_model.dart';

class ScheduleDetail {
  int id;
  String title;
  String description;
  DateTime startAt;
  DateTime endAt;

  ScheduleDetail(
      this.id, this.title, this.description, this.startAt, this.endAt);

  factory ScheduleDetail.from(ScheduleDetailModel model) {
    return ScheduleDetail(
        model.id, model.title, model.description, model.startAt, model.endAt);
  }

  @override
  String toString() {
    return "ScheduleDetail(id=$id,title=$title,description=$description,startAt=$startAt,endAt=$endAt)";
  }
}
