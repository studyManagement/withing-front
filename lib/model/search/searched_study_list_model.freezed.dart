// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'searched_study_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudyInfo _$StudyInfoFromJson(Map<String, dynamic> json) {
  return _StudyInfo.fromJson(json);
}

/// @nodoc
mixin _$StudyInfo {
  int get studyId => throw _privateConstructorUsedError;
  String get studyName => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  @JsonKey(name: 'headcount')
  int get headCount => throw _privateConstructorUsedError;
  String? get studyImage => throw _privateConstructorUsedError;
  List<String> get categoryList => throw _privateConstructorUsedError;
  int? get regularMeetingId => throw _privateConstructorUsedError;
  int get gap => throw _privateConstructorUsedError;
  int get day1 => throw _privateConstructorUsedError;
  int get day2 => throw _privateConstructorUsedError;
  int get day3 => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError; // LocalTime
  String get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyInfoCopyWith<StudyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyInfoCopyWith<$Res> {
  factory $StudyInfoCopyWith(StudyInfo value, $Res Function(StudyInfo) then) =
      _$StudyInfoCopyWithImpl<$Res, StudyInfo>;
  @useResult
  $Res call(
      {int studyId,
      String studyName,
      int max,
      @JsonKey(name: 'headcount') int headCount,
      String? studyImage,
      List<String> categoryList,
      int? regularMeetingId,
      int gap,
      int day1,
      int day2,
      int day3,
      String startTime,
      String endTime});
}

/// @nodoc
class _$StudyInfoCopyWithImpl<$Res, $Val extends StudyInfo>
    implements $StudyInfoCopyWith<$Res> {
  _$StudyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyId = null,
    Object? studyName = null,
    Object? max = null,
    Object? headCount = null,
    Object? studyImage = freezed,
    Object? categoryList = null,
    Object? regularMeetingId = freezed,
    Object? gap = null,
    Object? day1 = null,
    Object? day2 = null,
    Object? day3 = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      studyName: null == studyName
          ? _value.studyName
          : studyName // ignore: cast_nullable_to_non_nullable
              as String,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      headCount: null == headCount
          ? _value.headCount
          : headCount // ignore: cast_nullable_to_non_nullable
              as int,
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryList: null == categoryList
          ? _value.categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regularMeetingId: freezed == regularMeetingId
          ? _value.regularMeetingId
          : regularMeetingId // ignore: cast_nullable_to_non_nullable
              as int?,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
      day1: null == day1
          ? _value.day1
          : day1 // ignore: cast_nullable_to_non_nullable
              as int,
      day2: null == day2
          ? _value.day2
          : day2 // ignore: cast_nullable_to_non_nullable
              as int,
      day3: null == day3
          ? _value.day3
          : day3 // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$StudyInfoImplCopyWith<$Res>
    implements $StudyInfoCopyWith<$Res> {
  factory _$$StudyInfoImplCopyWith(
          _$StudyInfoImpl value, $Res Function(_$StudyInfoImpl) then) =
      __$$StudyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int studyId,
      String studyName,
      int max,
      @JsonKey(name: 'headcount') int headCount,
      String? studyImage,
      List<String> categoryList,
      int? regularMeetingId,
      int gap,
      int day1,
      int day2,
      int day3,
      String startTime,
      String endTime});
}

/// @nodoc
class __$$StudyInfoImplCopyWithImpl<$Res>
    extends _$StudyInfoCopyWithImpl<$Res, _$StudyInfoImpl>
    implements _$$StudyInfoImplCopyWith<$Res> {
  __$$StudyInfoImplCopyWithImpl(
      _$StudyInfoImpl _value, $Res Function(_$StudyInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyId = null,
    Object? studyName = null,
    Object? max = null,
    Object? headCount = null,
    Object? studyImage = freezed,
    Object? categoryList = null,
    Object? regularMeetingId = freezed,
    Object? gap = null,
    Object? day1 = null,
    Object? day2 = null,
    Object? day3 = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$StudyInfoImpl(
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      studyName: null == studyName
          ? _value.studyName
          : studyName // ignore: cast_nullable_to_non_nullable
              as String,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      headCount: null == headCount
          ? _value.headCount
          : headCount // ignore: cast_nullable_to_non_nullable
              as int,
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryList: null == categoryList
          ? _value._categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regularMeetingId: freezed == regularMeetingId
          ? _value.regularMeetingId
          : regularMeetingId // ignore: cast_nullable_to_non_nullable
              as int?,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
      day1: null == day1
          ? _value.day1
          : day1 // ignore: cast_nullable_to_non_nullable
              as int,
      day2: null == day2
          ? _value.day2
          : day2 // ignore: cast_nullable_to_non_nullable
              as int,
      day3: null == day3
          ? _value.day3
          : day3 // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$StudyInfoImpl implements _StudyInfo {
  const _$StudyInfoImpl(
      {required this.studyId,
      required this.studyName,
      required this.max,
      @JsonKey(name: 'headcount') required this.headCount,
      required this.studyImage,
      required final List<String> categoryList,
      required this.regularMeetingId,
      required this.gap,
      required this.day1,
      required this.day2,
      required this.day3,
      required this.startTime,
      required this.endTime})
      : _categoryList = categoryList;

  factory _$StudyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyInfoImplFromJson(json);

  @override
  final int studyId;
  @override
  final String studyName;
  @override
  final int max;
  @override
  @JsonKey(name: 'headcount')
  final int headCount;
  @override
  final String? studyImage;
  final List<String> _categoryList;
  @override
  List<String> get categoryList {
    if (_categoryList is EqualUnmodifiableListView) return _categoryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryList);
  }

  @override
  final int? regularMeetingId;
  @override
  final int gap;
  @override
  final int day1;
  @override
  final int day2;
  @override
  final int day3;
  @override
  final String startTime;
// LocalTime
  @override
  final String endTime;

  @override
  String toString() {
    return 'StudyInfo(studyId: $studyId, studyName: $studyName, max: $max, headCount: $headCount, studyImage: $studyImage, categoryList: $categoryList, regularMeetingId: $regularMeetingId, gap: $gap, day1: $day1, day2: $day2, day3: $day3, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyInfoImpl &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.studyName, studyName) ||
                other.studyName == studyName) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.headCount, headCount) ||
                other.headCount == headCount) &&
            (identical(other.studyImage, studyImage) ||
                other.studyImage == studyImage) &&
            const DeepCollectionEquality()
                .equals(other._categoryList, _categoryList) &&
            (identical(other.regularMeetingId, regularMeetingId) ||
                other.regularMeetingId == regularMeetingId) &&
            (identical(other.gap, gap) || other.gap == gap) &&
            (identical(other.day1, day1) || other.day1 == day1) &&
            (identical(other.day2, day2) || other.day2 == day2) &&
            (identical(other.day3, day3) || other.day3 == day3) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      studyId,
      studyName,
      max,
      headCount,
      studyImage,
      const DeepCollectionEquality().hash(_categoryList),
      regularMeetingId,
      gap,
      day1,
      day2,
      day3,
      startTime,
      endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyInfoImplCopyWith<_$StudyInfoImpl> get copyWith =>
      __$$StudyInfoImplCopyWithImpl<_$StudyInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyInfoImplToJson(
      this,
    );
  }
}

abstract class _StudyInfo implements StudyInfo {
  const factory _StudyInfo(
      {required final int studyId,
      required final String studyName,
      required final int max,
      @JsonKey(name: 'headcount') required final int headCount,
      required final String? studyImage,
      required final List<String> categoryList,
      required final int? regularMeetingId,
      required final int gap,
      required final int day1,
      required final int day2,
      required final int day3,
      required final String startTime,
      required final String endTime}) = _$StudyInfoImpl;

  factory _StudyInfo.fromJson(Map<String, dynamic> json) =
      _$StudyInfoImpl.fromJson;

  @override
  int get studyId;
  @override
  String get studyName;
  @override
  int get max;
  @override
  @JsonKey(name: 'headcount')
  int get headCount;
  @override
  String? get studyImage;
  @override
  List<String> get categoryList;
  @override
  int? get regularMeetingId;
  @override
  int get gap;
  @override
  int get day1;
  @override
  int get day2;
  @override
  int get day3;
  @override
  String get startTime;
  @override // LocalTime
  String get endTime;
  @override
  @JsonKey(ignore: true)
  _$$StudyInfoImplCopyWith<_$StudyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
