// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyModelImpl _$$StudyModelImplFromJson(Map<String, dynamic> json) =>
    _$StudyModelImpl(
      id: json['id'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headcount: json['headcount'] as int,
      private: json['private'] as bool,
      finished: json['finished'] as bool,
      explanation: json['explanation'] as String,
      leaderId: json['leaderId'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      studyImage: json['studyImage'] as String?,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      meetingSchedules: (json['meetingSchedules'] as List<dynamic>)
          .map((e) =>
              StudyMeetingSchedulesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StudyModelImplToJson(_$StudyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headcount,
      'private': instance.private,
      'finished': instance.finished,
      'explanation': instance.explanation,
      'leaderId': instance.leaderId,
      'createdAt': instance.createdAt.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'studyImage': instance.studyImage,
      'categories': instance.categories,
      'meetingSchedules': instance.meetingSchedules,
      'users': instance.users,
    };
