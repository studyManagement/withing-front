// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) {
  return _NoticeModel.fromJson(json);
}

/// @nodoc
mixin _$NoticeModel {
  String get createdAt => throw _privateConstructorUsedError;
  String get contents => throw _privateConstructorUsedError;
  int get boardId => throw _privateConstructorUsedError;
  int get studyId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get notice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoticeModelCopyWith<NoticeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeModelCopyWith<$Res> {
  factory $NoticeModelCopyWith(
          NoticeModel value, $Res Function(NoticeModel) then) =
      _$NoticeModelCopyWithImpl<$Res, NoticeModel>;
  @useResult
  $Res call(
      {String createdAt,
      String contents,
      int boardId,
      int studyId,
      String title,
      int userId,
      int notice});
}

/// @nodoc
class _$NoticeModelCopyWithImpl<$Res, $Val extends NoticeModel>
    implements $NoticeModelCopyWith<$Res> {
  _$NoticeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? contents = null,
    Object? boardId = null,
    Object? studyId = null,
    Object? title = null,
    Object? userId = null,
    Object? notice = null,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      boardId: null == boardId
          ? _value.boardId
          : boardId // ignore: cast_nullable_to_non_nullable
              as int,
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      notice: null == notice
          ? _value.notice
          : notice // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoticeModelImplCopyWith<$Res>
    implements $NoticeModelCopyWith<$Res> {
  factory _$$NoticeModelImplCopyWith(
          _$NoticeModelImpl value, $Res Function(_$NoticeModelImpl) then) =
      __$$NoticeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String createdAt,
      String contents,
      int boardId,
      int studyId,
      String title,
      int userId,
      int notice});
}

/// @nodoc
class __$$NoticeModelImplCopyWithImpl<$Res>
    extends _$NoticeModelCopyWithImpl<$Res, _$NoticeModelImpl>
    implements _$$NoticeModelImplCopyWith<$Res> {
  __$$NoticeModelImplCopyWithImpl(
      _$NoticeModelImpl _value, $Res Function(_$NoticeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? contents = null,
    Object? boardId = null,
    Object? studyId = null,
    Object? title = null,
    Object? userId = null,
    Object? notice = null,
  }) {
    return _then(_$NoticeModelImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String,
      boardId: null == boardId
          ? _value.boardId
          : boardId // ignore: cast_nullable_to_non_nullable
              as int,
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      notice: null == notice
          ? _value.notice
          : notice // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeModelImpl implements _NoticeModel {
  const _$NoticeModelImpl(
      {required this.createdAt,
      required this.contents,
      required this.boardId,
      required this.studyId,
      required this.title,
      required this.userId,
      required this.notice});

  factory _$NoticeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeModelImplFromJson(json);

  @override
  final String createdAt;
  @override
  final String contents;
  @override
  final int boardId;
  @override
  final int studyId;
  @override
  final String title;
  @override
  final int userId;
  @override
  final int notice;

  @override
  String toString() {
    return 'NoticeModel(createdAt: $createdAt, contents: $contents, boardId: $boardId, studyId: $studyId, title: $title, userId: $userId, notice: $notice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeModelImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.contents, contents) ||
                other.contents == contents) &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.notice, notice) || other.notice == notice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, createdAt, contents, boardId,
      studyId, title, userId, notice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeModelImplCopyWith<_$NoticeModelImpl> get copyWith =>
      __$$NoticeModelImplCopyWithImpl<_$NoticeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeModelImplToJson(
      this,
    );
  }
}

abstract class _NoticeModel implements NoticeModel {
  const factory _NoticeModel(
      {required final String createdAt,
      required final String contents,
      required final int boardId,
      required final int studyId,
      required final String title,
      required final int userId,
      required final int notice}) = _$NoticeModelImpl;

  factory _NoticeModel.fromJson(Map<String, dynamic> json) =
      _$NoticeModelImpl.fromJson;

  @override
  String get createdAt;
  @override
  String get contents;
  @override
  int get boardId;
  @override
  int get studyId;
  @override
  String get title;
  @override
  int get userId;
  @override
  int get notice;
  @override
  @JsonKey(ignore: true)
  _$$NoticeModelImplCopyWith<_$NoticeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
