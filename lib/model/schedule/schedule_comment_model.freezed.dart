// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleCommentModel _$ScheduleCommentModelFromJson(Map<String, dynamic> json) {
  return _ScheduleCommentModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleCommentModel {
  int get id => throw _privateConstructorUsedError;
  int get studyId => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleCommentModelCopyWith<ScheduleCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCommentModelCopyWith<$Res> {
  factory $ScheduleCommentModelCopyWith(ScheduleCommentModel value,
          $Res Function(ScheduleCommentModel) then) =
      _$ScheduleCommentModelCopyWithImpl<$Res, ScheduleCommentModel>;
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      String content,
      DateTime createdAt});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$ScheduleCommentModelCopyWithImpl<$Res,
        $Val extends ScheduleCommentModel>
    implements $ScheduleCommentModelCopyWith<$Res> {
  _$ScheduleCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyId = null,
    Object? user = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScheduleCommentModelImplCopyWith<$Res>
    implements $ScheduleCommentModelCopyWith<$Res> {
  factory _$$ScheduleCommentModelImplCopyWith(_$ScheduleCommentModelImpl value,
          $Res Function(_$ScheduleCommentModelImpl) then) =
      __$$ScheduleCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      String content,
      DateTime createdAt});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$ScheduleCommentModelImplCopyWithImpl<$Res>
    extends _$ScheduleCommentModelCopyWithImpl<$Res, _$ScheduleCommentModelImpl>
    implements _$$ScheduleCommentModelImplCopyWith<$Res> {
  __$$ScheduleCommentModelImplCopyWithImpl(_$ScheduleCommentModelImpl _value,
      $Res Function(_$ScheduleCommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyId = null,
    Object? user = null,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_$ScheduleCommentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleCommentModelImpl implements _ScheduleCommentModel {
  const _$ScheduleCommentModelImpl(
      {required this.id,
      required this.studyId,
      required this.user,
      required this.content,
      required this.createdAt});

  factory _$ScheduleCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleCommentModelImplFromJson(json);

  @override
  final int id;
  @override
  final int studyId;
  @override
  final UserModel user;
  @override
  final String content;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ScheduleCommentModel(id: $id, studyId: $studyId, user: $user, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleCommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, studyId, user, content, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleCommentModelImplCopyWith<_$ScheduleCommentModelImpl>
      get copyWith =>
          __$$ScheduleCommentModelImplCopyWithImpl<_$ScheduleCommentModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleCommentModelImplToJson(
      this,
    );
  }
}

abstract class _ScheduleCommentModel implements ScheduleCommentModel {
  const factory _ScheduleCommentModel(
      {required final int id,
      required final int studyId,
      required final UserModel user,
      required final String content,
      required final DateTime createdAt}) = _$ScheduleCommentModelImpl;

  factory _ScheduleCommentModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleCommentModelImpl.fromJson;

  @override
  int get id;
  @override
  int get studyId;
  @override
  UserModel get user;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleCommentModelImplCopyWith<_$ScheduleCommentModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
