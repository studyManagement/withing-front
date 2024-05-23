// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserScheduleModelImpl _$$UserScheduleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserScheduleModelImpl(
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      studyName: json['studyName'] as String,
      scheduleName: json['scheduleName'] as String,
    );

Map<String, dynamic> _$$UserScheduleModelImplToJson(
        _$UserScheduleModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'studyName': instance.studyName,
      'scheduleName': instance.scheduleName,
    };
