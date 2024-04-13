import 'package:modi/model/schedule/schedule_vote_item_model.dart';

class ScheduleVoteItem {
  int id;
  int studyId;
  DateTime voteDay;
  DateTime startAt;
  DateTime endAt;
  DateTime createdAt;

  ScheduleVoteItem(
    this.id,
    this.studyId,
    this.voteDay,
    this.startAt,
    this.endAt,
    this.createdAt,
  );

  factory ScheduleVoteItem.from(ScheduleVoteItemModel model) {
    return ScheduleVoteItem(
      model.id,
      model.studyId,
      model.voteDay,
      model.startAt,
      model.endAt,
      model.createdAt,
    );
  }

  @override
  String toString() {
    return "ScheduleVoteItem(id=$id,studyId=$studyId,voteDay=$voteDay,startAt=$startAt,endAt=$endAt,createdAt=$createdAt)";
  }
}
