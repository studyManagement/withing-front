// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleDetailModelImpl _$$ScheduleDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduleDetailModelImpl(
      id: json['id'] as int,
      studyId: json['studyId'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
    );

Map<String, dynamic> _$$ScheduleDetailModelImplToJson(
        _$ScheduleDetailModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyId': instance.studyId,
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
    };
