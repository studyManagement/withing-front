import 'package:flutter/material.dart';
import 'package:modi/common/components/table/schedule/schedule_table_vote_status.dart';
import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:modi/view_models/schedule/model/schedule_vote_item.dart';
import 'package:modi/view_models/schedule/model/schedule_vote_item_status.dart';

class ScheduleVoteItemAggregate {
  DateTime voteDay;
  TimeOfDay selectedTime;
  List<UserModel> users;

  ScheduleVoteItemAggregate(
    this.voteDay,
    this.selectedTime,
    this.users,
  );
}

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

  Set<TimeOfDay> get selectedTimes {
    return votes
        .map((vote) => vote.status.map((e) => e.selectedTime))
        .expand((i) => i)
        .toSet();
  }

  List<ScheduleVoteItemAggregate> get voteAggregates {
    Set<TimeOfDay> uniqueTimes = selectedTimes;
    List<ScheduleVoteItemAggregate> aggregates = [];

    for (var vote in votes) {
      for (var time in uniqueTimes) {
        List<UserModel> users = vote.status
            .where((status) => status.selectedTime == time)
            .map((e) => e.user)
            .toList();
        aggregates.add(
          ScheduleVoteItemAggregate(
            vote.voteDay,
            time,
            users,
          ),
        );
      }
    }

    aggregates.sort((a, b) => a.users.length.compareTo(b.users.length));
    return aggregates.reversed.toList();
  }

  List<UserModel> get votedMembers {
    Set<UserModel> uniqueMembers = votes
        .map((vote) => vote.status.map((e) => e.user))
        .expand((i) => i)
        .toSet();
    return uniqueMembers.toList();
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
