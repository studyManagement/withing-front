// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_regular_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyRegularMeetingImpl _$$StudyRegularMeetingImplFromJson(
        Map<String, dynamic> json) =>
    _$StudyRegularMeetingImpl(
      regularMeetingId: json['regularMeetingId'] as int,
      gap: json['gap'] as int,
      day1: json['day1'] as int,
      day2: json['day2'] as int,
      day3: json['day3'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$$StudyRegularMeetingImplToJson(
        _$StudyRegularMeetingImpl instance) =>
    <String, dynamic>{
      'regularMeetingId': instance.regularMeetingId,
      'gap': instance.gap,
      'day1': instance.day1,
      'day2': instance.day2,
      'day3': instance.day3,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
