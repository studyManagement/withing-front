// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyListModelImpl _$$StudyListModelImplFromJson(Map<String, dynamic> json) =>
    _$StudyListModelImpl(
      id: json['id'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headcount: json['headcount'] as int,
      private: json['private'] as bool,
      explanation: json['explanation'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      meetingSchedules: (json['meetingSchedules'] as List<dynamic>)
          .map((e) =>
              StudyMeetingSchedulesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StudyListModelImplToJson(
        _$StudyListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headcount,
      'private': instance.private,
      'explanation': instance.explanation,
      'createdAt': instance.createdAt.toIso8601String(),
      'deadline': instance.deadline.toIso8601String(),
      'categories': instance.categories,
      'meetingSchedules': instance.meetingSchedules,
    };
