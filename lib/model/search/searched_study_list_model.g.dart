// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_study_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyInfoImpl _$$StudyInfoImplFromJson(Map<String, dynamic> json) =>
    _$StudyInfoImpl(
      studyId: json['studyId'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headCount: json['headcount'] as int,
      studyImage: json['studyImage'] as String?,
      categoryList: (json['categoryList'] as List<dynamic>)
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

Map<String, dynamic> _$$StudyInfoImplToJson(_$StudyInfoImpl instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headCount,
      'studyImage': instance.studyImage,
      'categoryList': instance.categoryList,
      'regularMeetingId': instance.regularMeetingId,
      'gap': instance.gap,
      'day1': instance.day1,
      'day2': instance.day2,
      'day3': instance.day3,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
