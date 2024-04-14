import 'package:flutter/material.dart';
import 'package:modi/model/user/user_model.dart';

import '../../../common/components/table/schedule/schedule_table_vote_status.dart';
import '../../../model/schedule/schedule_vote_item_status_model.dart';

class ScheduleVoteItemStatus {
  int id;
  int studyId;
  UserModel user;
  TimeOfDay selectedTime;
  DateTime createdAt;

  ScheduleVoteItemStatus(
    this.id,
    this.studyId,
    this.user,
    this.selectedTime,
    this.createdAt,
  );

  ScheduleTableVoteStatus toTableVoteStatus() {
    return ScheduleTableVoteStatus(
      user.nickname,
      user.profileImage,
      selectedTime,
    );
  }

  factory ScheduleVoteItemStatus.from(ScheduleVoteItemStatusModel model) {
    return ScheduleVoteItemStatus(
      model.id,
      model.studyId,
      model.user,
      model.selectedTime,
      model.createdAt,
    );
  }
}
