// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_vote_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleVoteItemModel _$ScheduleVoteItemModelFromJson(
    Map<String, dynamic> json) {
  return _ScheduleVoteItemModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleVoteItemModel {
  int get id => throw _privateConstructorUsedError;
  int get studyId => throw _privateConstructorUsedError;
  DateTime get voteDay => throw _privateConstructorUsedError;
  @TimeOfDayConverter()
  TimeOfDay get startAt => throw _privateConstructorUsedError;
  @TimeOfDayConverter()
  TimeOfDay get endAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleVoteItemModelCopyWith<ScheduleVoteItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleVoteItemModelCopyWith<$Res> {
  factory $ScheduleVoteItemModelCopyWith(ScheduleVoteItemModel value,
          $Res Function(ScheduleVoteItemModel) then) =
      _$ScheduleVoteItemModelCopyWithImpl<$Res, ScheduleVoteItemModel>;
  @useResult
  $Res call(
      {int id,
      int studyId,
      DateTime voteDay,
      @TimeOfDayConverter() TimeOfDay startAt,
      @TimeOfDayConverter() TimeOfDay endAt,
      DateTime createdAt});
}

/// @nodoc
class _$ScheduleVoteItemModelCopyWithImpl<$Res,
        $Val extends ScheduleVoteItemModel>
    implements $ScheduleVoteItemModelCopyWith<$Res> {
  _$ScheduleVoteItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyId = null,
    Object? voteDay = null,
    Object? startAt = null,
    Object? endAt = null,
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
      voteDay: null == voteDay
          ? _value.voteDay
          : voteDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleVoteItemModelImplCopyWith<$Res>
    implements $ScheduleVoteItemModelCopyWith<$Res> {
  factory _$$ScheduleVoteItemModelImplCopyWith(
          _$ScheduleVoteItemModelImpl value,
          $Res Function(_$ScheduleVoteItemModelImpl) then) =
      __$$ScheduleVoteItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int studyId,
      DateTime voteDay,
      @TimeOfDayConverter() TimeOfDay startAt,
      @TimeOfDayConverter() TimeOfDay endAt,
      DateTime createdAt});
}

/// @nodoc
class __$$ScheduleVoteItemModelImplCopyWithImpl<$Res>
    extends _$ScheduleVoteItemModelCopyWithImpl<$Res,
        _$ScheduleVoteItemModelImpl>
    implements _$$ScheduleVoteItemModelImplCopyWith<$Res> {
  __$$ScheduleVoteItemModelImplCopyWithImpl(_$ScheduleVoteItemModelImpl _value,
      $Res Function(_$ScheduleVoteItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyId = null,
    Object? voteDay = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? createdAt = null,
  }) {
    return _then(_$ScheduleVoteItemModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      voteDay: null == voteDay
          ? _value.voteDay
          : voteDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
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
class _$ScheduleVoteItemModelImpl implements _ScheduleVoteItemModel {
  const _$ScheduleVoteItemModelImpl(
      {required this.id,
      required this.studyId,
      required this.voteDay,
      @TimeOfDayConverter() required this.startAt,
      @TimeOfDayConverter() required this.endAt,
      required this.createdAt});

  factory _$ScheduleVoteItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleVoteItemModelImplFromJson(json);

  @override
  final int id;
  @override
  final int studyId;
  @override
  final DateTime voteDay;
  @override
  @TimeOfDayConverter()
  final TimeOfDay startAt;
  @override
  @TimeOfDayConverter()
  final TimeOfDay endAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ScheduleVoteItemModel(id: $id, studyId: $studyId, voteDay: $voteDay, startAt: $startAt, endAt: $endAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleVoteItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.voteDay, voteDay) || other.voteDay == voteDay) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, studyId, voteDay, startAt, endAt, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleVoteItemModelImplCopyWith<_$ScheduleVoteItemModelImpl>
      get copyWith => __$$ScheduleVoteItemModelImplCopyWithImpl<
          _$ScheduleVoteItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleVoteItemModelImplToJson(
      this,
    );
  }
}

abstract class _ScheduleVoteItemModel implements ScheduleVoteItemModel {
  const factory _ScheduleVoteItemModel(
      {required final int id,
      required final int studyId,
      required final DateTime voteDay,
      @TimeOfDayConverter() required final TimeOfDay startAt,
      @TimeOfDayConverter() required final TimeOfDay endAt,
      required final DateTime createdAt}) = _$ScheduleVoteItemModelImpl;

  factory _ScheduleVoteItemModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleVoteItemModelImpl.fromJson;

  @override
  int get id;
  @override
  int get studyId;
  @override
  DateTime get voteDay;
  @override
  @TimeOfDayConverter()
  TimeOfDay get startAt;
  @override
  @TimeOfDayConverter()
  TimeOfDay get endAt;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleVoteItemModelImplCopyWith<_$ScheduleVoteItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
