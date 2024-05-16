import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_schedule_model.freezed.dart';
part 'user_schedule_model.g.dart';

@freezed
class UserScheduleModel with _$UserScheduleModel {
  const factory UserScheduleModel({
    required String date,
    required String startTime,
    required String endTime,
    required String studyName,
    required String scheduleName,
  }) = _UserScheduleModel;

  factory UserScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$UserScheduleModelFromJson(json);
}