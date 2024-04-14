import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modi/model/user/user_model.dart';

import '../../common/annotations/TimeOfDayConverter.dart';

part 'schedule_vote_item_status_model.freezed.dart';
part 'schedule_vote_item_status_model.g.dart';

@freezed
class ScheduleVoteItemStatusModel with _$ScheduleVoteItemStatusModel {
  const factory ScheduleVoteItemStatusModel({
    required int id,
    required int studyId,
    required UserModel user,
    @TimeOfDayConverter() required TimeOfDay selectedTime,
    required DateTime createdAt,
  }) = _ScheduleVoteItemStatusModel;

  factory ScheduleVoteItemStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleVoteItemStatusModelFromJson(json);
}
