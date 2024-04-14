import 'package:flutter/material.dart';
import 'package:modi/model/schedule/schedule_vote_item_model.dart';
import 'package:modi/view_models/schedule/model/schedule_vote_item_status.dart';

class ScheduleVoteItem {
  int id;
  int studyId;
  DateTime voteDay;
  List<ScheduleVoteItemStatus> status;
  TimeOfDay startAt;
  TimeOfDay endAt;
  DateTime createdAt;

  ScheduleVoteItem(
    this.id,
    this.studyId,
    this.voteDay,
    this.status,
    this.startAt,
    this.endAt,
    this.createdAt,
  );

  factory ScheduleVoteItem.from(ScheduleVoteItemModel model) {
    return ScheduleVoteItem(
      model.id,
      model.studyId,
      model.voteDay,
      model.status.map((e) => ScheduleVoteItemStatus.from(e)).toList(),
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
