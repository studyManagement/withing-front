import 'package:modi/common/components/table/schedule/schedule_table_vote_status.dart';
import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:modi/view_models/schedule/model/schedule_vote_item.dart';
import 'package:modi/view_models/schedule/model/schedule_vote_item_status.dart';

class ScheduleVote {
  int id;
  int studyId;
  UserModel user;
  String title;
  String description;
  List<ScheduleVoteItem> votes;
  DateTime createdAt;

  ScheduleVote(
    this.id,
    this.studyId,
    this.user,
    this.title,
    this.description,
    this.votes,
    this.createdAt,
  );

  int get totalVoteCount {
    Set<int> uniqueMembers = votes
        .map((vote) => vote.status.map((e) => e.id))
        .expand((i) => i)
        .toSet();
    return uniqueMembers.length;
  }

  bool isVoted(int userId) {
    return votes
        .any((vote) => vote.status.any((status) => status.user.id == userId));
  }

  Map<int, List<ScheduleTableVoteStatus>> toTableVoteStatus() {
    Iterable<List<ScheduleVoteItemStatus>> statuses =
        votes.map((e) => e.status);
    return statuses
        .map((e) => e.map((e) => e.toTableVoteStatus()).toList())
        .toList()
        .asMap();
  }

  factory ScheduleVote.from(ScheduleVoteModel model) {
    return ScheduleVote(
      model.id,
      model.studyId,
      model.user,
      model.title,
      model.description,
      model.votes.map((e) => ScheduleVoteItem.from(e)).toList(),
      model.createdAt,
    );
  }

  @override
  String toString() {
    return "ScheduleVote(id=$id,studyId=$studyId,user=$user,title=$title,description=$description,votes=$votes,createdAt=$createdAt)";
  }
}
