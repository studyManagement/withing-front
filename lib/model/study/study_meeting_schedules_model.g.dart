// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_meeting_schedules_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyMeetingSchedulesModelImpl _$$StudyMeetingSchedulesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StudyMeetingSchedulesModelImpl(
      id: json['id'] as int,
      day: json['day'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$$StudyMeetingSchedulesModelImplToJson(
        _$StudyMeetingSchedulesModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
