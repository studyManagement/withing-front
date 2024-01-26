// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyModelImpl _$$StudyModelImplFromJson(Map<String, dynamic> json) =>
    _$StudyModelImpl(
      studyId: json['studyId'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headcount: json['headcount'] as int,
      explanation: json['explanation'] as String,
      leaderId: json['leaderId'] as int,
      studyImage: json['studyImage'] as String?,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      gap: json['gap'] as int,
      days: (json['days'] as List<dynamic>?)?.map((e) => e as int).toList(),
      startTime: json['startTime'] as String?,
    );

Map<String, dynamic> _$$StudyModelImplToJson(_$StudyModelImpl instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headcount,
      'explanation': instance.explanation,
      'leaderId': instance.leaderId,
      'studyImage': instance.studyImage,
      'categories': instance.categories,
      'gap': instance.gap,
      'days': instance.days,
      'startTime': instance.startTime,
    };
