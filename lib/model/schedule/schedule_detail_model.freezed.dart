// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleDetailModel _$ScheduleDetailModelFromJson(Map<String, dynamic> json) {
  return _ScheduleDetailModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleDetailModel {
  int get id => throw _privateConstructorUsedError;
  int get studyId => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startAt => throw _privateConstructorUsedError;
  DateTime get endAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleDetailModelCopyWith<ScheduleDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleDetailModelCopyWith<$Res> {
  factory $ScheduleDetailModelCopyWith(
          ScheduleDetailModel value, $Res Function(ScheduleDetailModel) then) =
      _$ScheduleDetailModelCopyWithImpl<$Res, ScheduleDetailModel>;
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      String title,
      String description,
      DateTime startAt,
      DateTime endAt});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$ScheduleDetailModelCopyWithImpl<$Res, $Val extends ScheduleDetailModel>
    implements $ScheduleDetailModelCopyWith<$Res> {
  _$ScheduleDetailModelCopyWithImpl(this._value, this._then);

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
    Object? title = null,
    Object? description = null,
    Object? startAt = null,
    Object? endAt = null,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ScheduleDetailModelImplCopyWith<$Res>
    implements $ScheduleDetailModelCopyWith<$Res> {
  factory _$$ScheduleDetailModelImplCopyWith(_$ScheduleDetailModelImpl value,
          $Res Function(_$ScheduleDetailModelImpl) then) =
      __$$ScheduleDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      String title,
      String description,
      DateTime startAt,
      DateTime endAt});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$ScheduleDetailModelImplCopyWithImpl<$Res>
    extends _$ScheduleDetailModelCopyWithImpl<$Res, _$ScheduleDetailModelImpl>
    implements _$$ScheduleDetailModelImplCopyWith<$Res> {
  __$$ScheduleDetailModelImplCopyWithImpl(_$ScheduleDetailModelImpl _value,
      $Res Function(_$ScheduleDetailModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyId = null,
    Object? user = null,
    Object? title = null,
    Object? description = null,
    Object? startAt = null,
    Object? endAt = null,
  }) {
    return _then(_$ScheduleDetailModelImpl(
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleDetailModelImpl implements _ScheduleDetailModel {
  const _$ScheduleDetailModelImpl(
      {required this.id,
      required this.studyId,
      required this.user,
      required this.title,
      required this.description,
      required this.startAt,
      required this.endAt});

  factory _$ScheduleDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleDetailModelImplFromJson(json);

  @override
  final int id;
  @override
  final int studyId;
  @override
  final UserModel user;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startAt;
  @override
  final DateTime endAt;

  @override
  String toString() {
    return 'ScheduleDetailModel(id: $id, studyId: $studyId, user: $user, title: $title, description: $description, startAt: $startAt, endAt: $endAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleDetailModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, studyId, user, title, description, startAt, endAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleDetailModelImplCopyWith<_$ScheduleDetailModelImpl> get copyWith =>
      __$$ScheduleDetailModelImplCopyWithImpl<_$ScheduleDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleDetailModelImplToJson(
      this,
    );
  }
}

abstract class _ScheduleDetailModel implements ScheduleDetailModel {
  const factory _ScheduleDetailModel(
      {required final int id,
      required final int studyId,
      required final UserModel user,
      required final String title,
      required final String description,
      required final DateTime startAt,
      required final DateTime endAt}) = _$ScheduleDetailModelImpl;

  factory _ScheduleDetailModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleDetailModelImpl.fromJson;

  @override
  int get id;
  @override
  int get studyId;
  @override
  UserModel get user;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startAt;
  @override
  DateTime get endAt;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleDetailModelImplCopyWith<_$ScheduleDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
