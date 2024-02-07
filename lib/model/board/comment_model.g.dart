// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      commentId: json['commentId'] as int,
      userId: json['userId'] as int,
      boardId: json['boardId'] as int,
      contents: json['contents'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      nickname: json['nickname'] as String,
      studyImage: json['studyImage'] as String,
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'userId': instance.userId,
      'boardId': instance.boardId,
      'contents': instance.contents,
      'createdAt': instance.createdAt.toIso8601String(),
      'nickname': instance.nickname,
      'studyImage': instance.studyImage,
    };
