import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modi/model/user/user_model.dart';

part 'schedule_comment_model.freezed.dart';
part 'schedule_comment_model.g.dart';

@freezed
class ScheduleCommentModel with _$ScheduleCommentModel {
  const factory ScheduleCommentModel({
    required int id,
    required int studyId,
    required UserModel user,
    required String content,
    required DateTime createdAt,
  }) = _ScheduleCommentModel;

  factory ScheduleCommentModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleCommentModelFromJson(json);
}
