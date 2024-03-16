import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modi/model/user/user_model.dart';

part 'schedule_detail_model.freezed.dart';
part 'schedule_detail_model.g.dart';

@freezed
class ScheduleDetailModel with _$ScheduleDetailModel {
  const factory ScheduleDetailModel({
    required int id,
    required int studyId,
    required UserModel user,
    required String title,
    required String description,
    required DateTime startAt,
    required DateTime endAt,
  }) = _ScheduleDetailModel;

  factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailModelFromJson(json);
}
