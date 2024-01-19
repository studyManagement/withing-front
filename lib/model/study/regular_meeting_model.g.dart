// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegularMeetingModelImpl _$$RegularMeetingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegularMeetingModelImpl(
      regularMeetingId: json['regularMeetingId'] as int,
      gap: json['gap'] as int,
      day1: json['day1'] as int,
      day2: json['day2'] as int,
      day3: json['day3'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$$RegularMeetingModelImplToJson(
        _$RegularMeetingModelImpl instance) =>
    <String, dynamic>{
      'regularMeetingId': instance.regularMeetingId,
      'gap': instance.gap,
      'day1': instance.day1,
      'day2': instance.day2,
      'day3': instance.day3,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };
