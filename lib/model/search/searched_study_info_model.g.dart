// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_study_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchedStudyInfoImpl _$$SearchedStudyInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchedStudyInfoImpl(
      id: json['id'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headcount: json['headcount'] as int,
      explanation: json['explanation'] as String,
      createdAt: json['createdAt'] as String,
      deadline: json['deadline'] as String?,
      studyImage: json['studyImage'] as String?,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      meetingSchedules: (json['meetingSchedules'] as List<dynamic>)
          .map((e) => MeetingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      private: json['private'] as bool,
    );

Map<String, dynamic> _$$SearchedStudyInfoImplToJson(
        _$SearchedStudyInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headcount,
      'explanation': instance.explanation,
      'createdAt': instance.createdAt,
      'deadline': instance.deadline,
      'studyImage': instance.studyImage,
      'categories': instance.categories,
      'meetingSchedules': instance.meetingSchedules,
      'private': instance.private,
    };

_$MeetingInfoImpl _$$MeetingInfoImplFromJson(Map<String, dynamic> json) =>
    _$MeetingInfoImpl(
      id: json['id'] as int,
      day: json['day'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$$MeetingInfoImplToJson(_$MeetingInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
