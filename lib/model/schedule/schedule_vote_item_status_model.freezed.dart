// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_vote_item_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleVoteItemStatusModel _$ScheduleVoteItemStatusModelFromJson(
    Map<String, dynamic> json) {
  return _ScheduleVoteItemStatusModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleVoteItemStatusModel {
  int get id => throw _privateConstructorUsedError;
  int get studyId => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  @TimeOfDayConverter()
  TimeOfDay get selectedTime => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleVoteItemStatusModelCopyWith<ScheduleVoteItemStatusModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleVoteItemStatusModelCopyWith<$Res> {
  factory $ScheduleVoteItemStatusModelCopyWith(
          ScheduleVoteItemStatusModel value,
          $Res Function(ScheduleVoteItemStatusModel) then) =
      _$ScheduleVoteItemStatusModelCopyWithImpl<$Res,
          ScheduleVoteItemStatusModel>;
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      @TimeOfDayConverter() TimeOfDay selectedTime,
      DateTime createdAt});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$ScheduleVoteItemStatusModelCopyWithImpl<$Res,
        $Val extends ScheduleVoteItemStatusModel>
    implements $ScheduleVoteItemStatusModelCopyWith<$Res> {
  _$ScheduleVoteItemStatusModelCopyWithImpl(this._value, this._then);

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
    Object? selectedTime = null,
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
      selectedTime: null == selectedTime
          ? _value.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
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
abstract class _$$ScheduleVoteItemStatusModelImplCopyWith<$Res>
    implements $ScheduleVoteItemStatusModelCopyWith<$Res> {
  factory _$$ScheduleVoteItemStatusModelImplCopyWith(
          _$ScheduleVoteItemStatusModelImpl value,
          $Res Function(_$ScheduleVoteItemStatusModelImpl) then) =
      __$$ScheduleVoteItemStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      @TimeOfDayConverter() TimeOfDay selectedTime,
      DateTime createdAt});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$ScheduleVoteItemStatusModelImplCopyWithImpl<$Res>
    extends _$ScheduleVoteItemStatusModelCopyWithImpl<$Res,
        _$ScheduleVoteItemStatusModelImpl>
    implements _$$ScheduleVoteItemStatusModelImplCopyWith<$Res> {
  __$$ScheduleVoteItemStatusModelImplCopyWithImpl(
      _$ScheduleVoteItemStatusModelImpl _value,
      $Res Function(_$ScheduleVoteItemStatusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyId = null,
    Object? user = null,
    Object? selectedTime = null,
    Object? createdAt = null,
  }) {
    return _then(_$ScheduleVoteItemStatusModelImpl(
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
      selectedTime: null == selectedTime
          ? _value.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleVoteItemStatusModelImpl
    implements _ScheduleVoteItemStatusModel {
  const _$ScheduleVoteItemStatusModelImpl(
      {required this.id,
      required this.studyId,
      required this.user,
      @TimeOfDayConverter() required this.selectedTime,
      required this.createdAt});

  factory _$ScheduleVoteItemStatusModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ScheduleVoteItemStatusModelImplFromJson(json);

  @override
  final int id;
  @override
  final int studyId;
  @override
  final UserModel user;
  @override
  @TimeOfDayConverter()
  final TimeOfDay selectedTime;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ScheduleVoteItemStatusModel(id: $id, studyId: $studyId, user: $user, selectedTime: $selectedTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleVoteItemStatusModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.selectedTime, selectedTime) ||
                other.selectedTime == selectedTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, studyId, user, selectedTime, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleVoteItemStatusModelImplCopyWith<_$ScheduleVoteItemStatusModelImpl>
      get copyWith => __$$ScheduleVoteItemStatusModelImplCopyWithImpl<
          _$ScheduleVoteItemStatusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleVoteItemStatusModelImplToJson(
      this,
    );
  }
}

abstract class _ScheduleVoteItemStatusModel
    implements ScheduleVoteItemStatusModel {
  const factory _ScheduleVoteItemStatusModel(
      {required final int id,
      required final int studyId,
      required final UserModel user,
      @TimeOfDayConverter() required final TimeOfDay selectedTime,
      required final DateTime createdAt}) = _$ScheduleVoteItemStatusModelImpl;

  factory _ScheduleVoteItemStatusModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleVoteItemStatusModelImpl.fromJson;

  @override
  int get id;
  @override
  int get studyId;
  @override
  UserModel get user;
  @override
  @TimeOfDayConverter()
  TimeOfDay get selectedTime;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleVoteItemStatusModelImplCopyWith<_$ScheduleVoteItemStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
