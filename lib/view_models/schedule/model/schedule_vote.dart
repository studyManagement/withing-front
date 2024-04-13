import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:modi/view_models/schedule/model/schedule_vote_item.dart';

class ScheduleVote {
  int id;
  int studyId;
  UserModel user;
  String title;
  String description;
  List<ScheduleVoteItem> votes;
  DateTime cratedAt;

  ScheduleVote(
    this.id,
    this.studyId,
    this.user,
    this.title,
    this.description,
    this.votes,
    this.cratedAt,
  );

  factory ScheduleVote.from(ScheduleVoteModel model) {
    return ScheduleVote(
      model.id,
      model.studyId,
      model.user,
      model.title,
      model.description,
      model.votes.map((e) => ScheduleVoteItem.from(e)).toList(),
      model.cratedAt,
    );
  }

  @override
  String toString() {
    return "ScheduleVote(id=$id,studyId=$studyId,user=$user,title=$title,description=$description,votes=$votes,cratedAt=$cratedAt)";
  }
}
