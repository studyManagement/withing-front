// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_study_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchedStudyInfoImpl _$$SearchedStudyInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchedStudyInfoImpl(
      studyId: json['studyId'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headCount: json['headcount'] as int,
      studyImage: json['studyImage'] as String?,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      regularMeetingId: json['regularMeetingId'] as int?,
      gap: json['gap'] as int,
      day1: json['day1'] as int,
      day2: json['day2'] as int,
      day3: json['day3'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$$SearchedStudyInfoImplToJson(
        _$SearchedStudyInfoImpl instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headCount,
      'studyImage': instance.studyImage,
      'categories': instance.categories,
      'regularMeetingId': instance.regularMeetingId,
      'gap': instance.gap,
      'day1': instance.day1,
      'day2': instance.day2,
      'day3': instance.day3,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
