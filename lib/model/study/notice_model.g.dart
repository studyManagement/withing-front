// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoticeModelImpl _$$NoticeModelImplFromJson(Map<String, dynamic> json) =>
    _$NoticeModelImpl(
      createdAt: json['createdAt'] as String,
      contents: json['contents'] as String,
      boardId: json['boardId'] as int,
      studyId: json['studyId'] as int,
      title: json['title'] as String,
      userId: json['userId'] as int,
      notice: json['notice'] as int,
    );

Map<String, dynamic> _$$NoticeModelImplToJson(_$NoticeModelImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'contents': instance.contents,
      'boardId': instance.boardId,
      'studyId': instance.studyId,
      'title': instance.title,
      'userId': instance.userId,
      'notice': instance.notice,
    };
