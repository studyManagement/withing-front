import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modi/common/annotations/TimeOfDayConverter.dart';
import 'package:modi/model/schedule/schedule_vote_item_status_model.dart';

part 'schedule_vote_item_model.freezed.dart';
part 'schedule_vote_item_model.g.dart';

@freezed
class ScheduleVoteItemModel with _$ScheduleVoteItemModel {
  const factory ScheduleVoteItemModel({
    required int id,
    required int studyId,
    required DateTime voteDay,
    required List<ScheduleVoteItemStatusModel> status,
    @TimeOfDayConverter() required TimeOfDay startAt,
    @TimeOfDayConverter() required TimeOfDay endAt,
    required DateTime createdAt,
  }) = _ScheduleVoteItemModel;

  factory ScheduleVoteItemModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleVoteItemModelFromJson(json);
}
