// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'created_study_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreatedStudyInfo _$CreatedStudyInfoFromJson(Map<String, dynamic> json) {
  return _CreatedStudyInfo.fromJson(json);
}

/// @nodoc
mixin _$CreatedStudyInfo {
  int get studyId => throw _privateConstructorUsedError;
  String get studyName => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  @JsonKey(name: 'headcount')
  int get headCount => throw _privateConstructorUsedError;
  int get isPrivate => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  String get createdDate => throw _privateConstructorUsedError;
  String get deadline => throw _privateConstructorUsedError;
  int get leaderId => throw _privateConstructorUsedError;
  List<int> get categories => throw _privateConstructorUsedError;
  String? get studyImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatedStudyInfoCopyWith<CreatedStudyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedStudyInfoCopyWith<$Res> {
  factory $CreatedStudyInfoCopyWith(
          CreatedStudyInfo value, $Res Function(CreatedStudyInfo) then) =
      _$CreatedStudyInfoCopyWithImpl<$Res, CreatedStudyInfo>;
  @useResult
  $Res call(
      {int studyId,
      String studyName,
      int max,
      @JsonKey(name: 'headcount') int headCount,
      int isPrivate,
      String password,
      String explanation,
      String createdDate,
      String deadline,
      int leaderId,
      List<int> categories,
      String? studyImage});
}

/// @nodoc
class _$CreatedStudyInfoCopyWithImpl<$Res, $Val extends CreatedStudyInfo>
    implements $CreatedStudyInfoCopyWith<$Res> {
  _$CreatedStudyInfoCopyWithImpl(this._value, this._then);

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
    Object? isPrivate = null,
    Object? password = null,
    Object? explanation = null,
    Object? createdDate = null,
    Object? deadline = null,
    Object? leaderId = null,
    Object? categories = null,
    Object? studyImage = freezed,
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
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as int,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: null == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as int,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>,
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatedStudyInfoImplCopyWith<$Res>
    implements $CreatedStudyInfoCopyWith<$Res> {
  factory _$$CreatedStudyInfoImplCopyWith(_$CreatedStudyInfoImpl value,
          $Res Function(_$CreatedStudyInfoImpl) then) =
      __$$CreatedStudyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int studyId,
      String studyName,
      int max,
      @JsonKey(name: 'headcount') int headCount,
      int isPrivate,
      String password,
      String explanation,
      String createdDate,
      String deadline,
      int leaderId,
      List<int> categories,
      String? studyImage});
}

/// @nodoc
class __$$CreatedStudyInfoImplCopyWithImpl<$Res>
    extends _$CreatedStudyInfoCopyWithImpl<$Res, _$CreatedStudyInfoImpl>
    implements _$$CreatedStudyInfoImplCopyWith<$Res> {
  __$$CreatedStudyInfoImplCopyWithImpl(_$CreatedStudyInfoImpl _value,
      $Res Function(_$CreatedStudyInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyId = null,
    Object? studyName = null,
    Object? max = null,
    Object? headCount = null,
    Object? isPrivate = null,
    Object? password = null,
    Object? explanation = null,
    Object? createdDate = null,
    Object? deadline = null,
    Object? leaderId = null,
    Object? categories = null,
    Object? studyImage = freezed,
  }) {
    return _then(_$CreatedStudyInfoImpl(
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
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as int,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: null == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as int,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>,
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatedStudyInfoImpl implements _CreatedStudyInfo {
  const _$CreatedStudyInfoImpl(
      {required this.studyId,
      required this.studyName,
      required this.max,
      @JsonKey(name: 'headcount') required this.headCount,
      required this.isPrivate,
      required this.password,
      required this.explanation,
      required this.createdDate,
      required this.deadline,
      required this.leaderId,
      required final List<int> categories,
      required this.studyImage})
      : _categories = categories;

  factory _$CreatedStudyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatedStudyInfoImplFromJson(json);

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
  final int isPrivate;
  @override
  final String password;
  @override
  final String explanation;
  @override
  final String createdDate;
  @override
  final String deadline;
  @override
  final int leaderId;
  final List<int> _categories;
  @override
  List<int> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final String? studyImage;

  @override
  String toString() {
    return 'CreatedStudyInfo(studyId: $studyId, studyName: $studyName, max: $max, headCount: $headCount, isPrivate: $isPrivate, password: $password, explanation: $explanation, createdDate: $createdDate, deadline: $deadline, leaderId: $leaderId, categories: $categories, studyImage: $studyImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedStudyInfoImpl &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.studyName, studyName) ||
                other.studyName == studyName) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.headCount, headCount) ||
                other.headCount == headCount) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.leaderId, leaderId) ||
                other.leaderId == leaderId) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.studyImage, studyImage) ||
                other.studyImage == studyImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      studyId,
      studyName,
      max,
      headCount,
      isPrivate,
      password,
      explanation,
      createdDate,
      deadline,
      leaderId,
      const DeepCollectionEquality().hash(_categories),
      studyImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedStudyInfoImplCopyWith<_$CreatedStudyInfoImpl> get copyWith =>
      __$$CreatedStudyInfoImplCopyWithImpl<_$CreatedStudyInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatedStudyInfoImplToJson(
      this,
    );
  }
}

abstract class _CreatedStudyInfo implements CreatedStudyInfo {
  const factory _CreatedStudyInfo(
      {required final int studyId,
      required final String studyName,
      required final int max,
      @JsonKey(name: 'headcount') required final int headCount,
      required final int isPrivate,
      required final String password,
      required final String explanation,
      required final String createdDate,
      required final String deadline,
      required final int leaderId,
      required final List<int> categories,
      required final String? studyImage}) = _$CreatedStudyInfoImpl;

  factory _CreatedStudyInfo.fromJson(Map<String, dynamic> json) =
      _$CreatedStudyInfoImpl.fromJson;

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
  int get isPrivate;
  @override
  String get password;
  @override
  String get explanation;
  @override
  String get createdDate;
  @override
  String get deadline;
  @override
  int get leaderId;
  @override
  List<int> get categories;
  @override
  String? get studyImage;
  @override
  @JsonKey(ignore: true)
  _$$CreatedStudyInfoImplCopyWith<_$CreatedStudyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
