import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modi/model/schedule/schedule_vote_item_model.dart';
import 'package:modi/model/user/user_model.dart';

part 'schedule_vote_model.freezed.dart';
part 'schedule_vote_model.g.dart';

@freezed
class ScheduleVoteModel with _$ScheduleVoteModel {
  const ScheduleVoteModel._();

  const factory ScheduleVoteModel({
    required int id,
    required int studyId,
    required UserModel user,
    required String title,
    required String description,
    required List<ScheduleVoteItemModel> votes,
    required DateTime createdAt,
    required String status
  }) = _ScheduleVoteModel;

  factory ScheduleVoteModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleVoteModelFromJson(json);
  bool get isFinished => status == "FINISHED";
}
