import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_vote_item_model.freezed.dart';
part 'schedule_vote_item_model.g.dart';

@freezed
class ScheduleVoteItemModel with _$ScheduleVoteItemModel {
  const factory ScheduleVoteItemModel({
    required int id,
    required int studyId,
    required DateTime voteDay,
    required DateTime startAt,
    required DateTime endAt,
    required List<ScheduleVoteItemModel> votes,
    required DateTime createdAt,
  }) = _ScheduleVoteItemModel;

  factory ScheduleVoteItemModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleVoteItemModelFromJson(json);
}
