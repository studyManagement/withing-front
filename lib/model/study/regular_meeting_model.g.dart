// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegularMeetingModelImpl _$$RegularMeetingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegularMeetingModelImpl(
      studyId: json['studyId'] as int,
      gap: json['gap'] as int,
      days: (json['days'] as List<dynamic>).map((e) => e as int).toList(),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$$RegularMeetingModelImplToJson(
        _$RegularMeetingModelImpl instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'gap': instance.gap,
      'days': instance.days,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
