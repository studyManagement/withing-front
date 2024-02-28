import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modi/model/schedule/schedule_model.dart';

part 'schedule_group_model.freezed.dart';
part 'schedule_group_model.g.dart';

@freezed
class ScheduleGroupModel with _$ScheduleGroupModel {
  const factory ScheduleGroupModel({
    required int id,
    required DateTime date,
    required List<ScheduleModel> schedules,
  }) = _ScheduleGroupModel;

  factory ScheduleGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleGroupModelFromJson(json);
}
