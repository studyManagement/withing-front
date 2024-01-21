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
      categories:
          (json['categories'] as List<dynamic>).map((e) => e as int).toList(),
      regularMeetingId: json['regularMeetingId'] as int?,
      gap: json['gap'] as int,
      days: (json['days'] as List<dynamic>).map((e) => e as int).toList(),
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
      'days': instance.days,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
