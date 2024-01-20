// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_meeting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RegularMeetingModel _$RegularMeetingModelFromJson(Map<String, dynamic> json) {
  return _RegularMeetingModel.fromJson(json);
}

/// @nodoc
mixin _$RegularMeetingModel {
  int get studyId => throw _privateConstructorUsedError;
  int get gap => throw _privateConstructorUsedError;
  List<int> get days => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegularMeetingModelCopyWith<RegularMeetingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegularMeetingModelCopyWith<$Res> {
  factory $RegularMeetingModelCopyWith(
          RegularMeetingModel value, $Res Function(RegularMeetingModel) then) =
      _$RegularMeetingModelCopyWithImpl<$Res, RegularMeetingModel>;
  @useResult
  $Res call(
      {int studyId, int gap, List<int> days, String startTime, String endTime});
}

/// @nodoc
class _$RegularMeetingModelCopyWithImpl<$Res, $Val extends RegularMeetingModel>
    implements $RegularMeetingModelCopyWith<$Res> {
  _$RegularMeetingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyId = null,
    Object? gap = null,
    Object? days = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegularMeetingModelImplCopyWith<$Res>
    implements $RegularMeetingModelCopyWith<$Res> {
  factory _$$RegularMeetingModelImplCopyWith(_$RegularMeetingModelImpl value,
          $Res Function(_$RegularMeetingModelImpl) then) =
      __$$RegularMeetingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int studyId, int gap, List<int> days, String startTime, String endTime});
}

/// @nodoc
class __$$RegularMeetingModelImplCopyWithImpl<$Res>
    extends _$RegularMeetingModelCopyWithImpl<$Res, _$RegularMeetingModelImpl>
    implements _$$RegularMeetingModelImplCopyWith<$Res> {
  __$$RegularMeetingModelImplCopyWithImpl(_$RegularMeetingModelImpl _value,
      $Res Function(_$RegularMeetingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyId = null,
    Object? gap = null,
    Object? days = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$RegularMeetingModelImpl(
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegularMeetingModelImpl implements _RegularMeetingModel {
  const _$RegularMeetingModelImpl(
      {required this.studyId,
      required this.gap,
      required final List<int> days,
      required this.startTime,
      required this.endTime})
      : _days = days;

  factory _$RegularMeetingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegularMeetingModelImplFromJson(json);

  @override
  final int studyId;
  @override
  final int gap;
  final List<int> _days;
  @override
  List<int> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final String startTime;
  @override
  final String endTime;

  @override
  String toString() {
    return 'RegularMeetingModel(studyId: $studyId, gap: $gap, days: $days, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegularMeetingModelImpl &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.gap, gap) || other.gap == gap) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, studyId, gap,
      const DeepCollectionEquality().hash(_days), startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegularMeetingModelImplCopyWith<_$RegularMeetingModelImpl> get copyWith =>
      __$$RegularMeetingModelImplCopyWithImpl<_$RegularMeetingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegularMeetingModelImplToJson(
      this,
    );
  }
}

abstract class _RegularMeetingModel implements RegularMeetingModel {
  const factory _RegularMeetingModel(
      {required final int studyId,
      required final int gap,
      required final List<int> days,
      required final String startTime,
      required final String endTime}) = _$RegularMeetingModelImpl;

  factory _RegularMeetingModel.fromJson(Map<String, dynamic> json) =
      _$RegularMeetingModelImpl.fromJson;

  @override
  int get studyId;
  @override
  int get gap;
  @override
  List<int> get days;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  @JsonKey(ignore: true)
  _$$RegularMeetingModelImplCopyWith<_$RegularMeetingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
