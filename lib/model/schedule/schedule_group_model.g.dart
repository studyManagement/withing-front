// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleGroupModelImpl _$$ScheduleGroupModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduleGroupModelImpl(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      schedules: (json['schedules'] as List<dynamic>)
          .map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ScheduleGroupModelImplToJson(
        _$ScheduleGroupModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'schedules': instance.schedules,
    };
