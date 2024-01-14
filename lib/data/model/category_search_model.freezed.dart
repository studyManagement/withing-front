// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CategorySearchModel _$CategorySearchModelFromJson(Map<String, dynamic> json) {
  return _CategorySearchModel.fromJson(json);
}

/// @nodoc
mixin _$CategorySearchModel {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  List<StudyGroup>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategorySearchModelCopyWith<CategorySearchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySearchModelCopyWith<$Res> {
  factory $CategorySearchModelCopyWith(
          CategorySearchModel value, $Res Function(CategorySearchModel) then) =
      _$CategorySearchModelCopyWithImpl<$Res, CategorySearchModel>;
  @useResult
  $Res call({int code, String message, bool success, List<StudyGroup>? data});
}

/// @nodoc
class _$CategorySearchModelCopyWithImpl<$Res, $Val extends CategorySearchModel>
    implements $CategorySearchModelCopyWith<$Res> {
  _$CategorySearchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? success = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<StudyGroup>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategorySearchModelImplCopyWith<$Res>
    implements $CategorySearchModelCopyWith<$Res> {
  factory _$$CategorySearchModelImplCopyWith(_$CategorySearchModelImpl value,
          $Res Function(_$CategorySearchModelImpl) then) =
      __$$CategorySearchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, bool success, List<StudyGroup>? data});
}

/// @nodoc
class __$$CategorySearchModelImplCopyWithImpl<$Res>
    extends _$CategorySearchModelCopyWithImpl<$Res, _$CategorySearchModelImpl>
    implements _$$CategorySearchModelImplCopyWith<$Res> {
  __$$CategorySearchModelImplCopyWithImpl(_$CategorySearchModelImpl _value,
      $Res Function(_$CategorySearchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? success = null,
    Object? data = freezed,
  }) {
    return _then(_$CategorySearchModelImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<StudyGroup>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategorySearchModelImpl implements _CategorySearchModel {
  const _$CategorySearchModelImpl(
      {required this.code,
      required this.message,
      required this.success,
      final List<StudyGroup>? data})
      : _data = data;

  factory _$CategorySearchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorySearchModelImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final bool success;
  final List<StudyGroup>? _data;
  @override
  List<StudyGroup>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CategorySearchModel(code: $code, message: $message, success: $success, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySearchModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, success,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySearchModelImplCopyWith<_$CategorySearchModelImpl> get copyWith =>
      __$$CategorySearchModelImplCopyWithImpl<_$CategorySearchModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorySearchModelImplToJson(
      this,
    );
  }
}

abstract class _CategorySearchModel implements CategorySearchModel {
  const factory _CategorySearchModel(
      {required final int code,
      required final String message,
      required final bool success,
      final List<StudyGroup>? data}) = _$CategorySearchModelImpl;

  factory _CategorySearchModel.fromJson(Map<String, dynamic> json) =
      _$CategorySearchModelImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  bool get success;
  @override
  List<StudyGroup>? get data;
  @override
  @JsonKey(ignore: true)
  _$$CategorySearchModelImplCopyWith<_$CategorySearchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudyGroup _$StudyGroupFromJson(Map<String, dynamic> json) {
  return _StudyGroup.fromJson(json);
}

/// @nodoc
mixin _$StudyGroup {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'team_name')
  String get teamName => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  @JsonKey(name: 'headcount')
  int get headCount => throw _privateConstructorUsedError;
  int get isPrivate => throw _privateConstructorUsedError;
  int get isFinished => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String get createdDate => throw _privateConstructorUsedError;
  String get deadline => throw _privateConstructorUsedError;
  @JsonKey(name: 'leader_id')
  int get leaderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyGroupCopyWith<StudyGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyGroupCopyWith<$Res> {
  factory $StudyGroupCopyWith(
          StudyGroup value, $Res Function(StudyGroup) then) =
      _$StudyGroupCopyWithImpl<$Res, StudyGroup>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'team_name') String teamName,
      int max,
      @JsonKey(name: 'headcount') int headCount,
      int isPrivate,
      int isFinished,
      String password,
      String explanation,
      @JsonKey(name: 'created_date') String createdDate,
      String deadline,
      @JsonKey(name: 'leader_id') int leaderId});
}

/// @nodoc
class _$StudyGroupCopyWithImpl<$Res, $Val extends StudyGroup>
    implements $StudyGroupCopyWith<$Res> {
  _$StudyGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teamName = null,
    Object? max = null,
    Object? headCount = null,
    Object? isPrivate = null,
    Object? isFinished = null,
    Object? password = null,
    Object? explanation = null,
    Object? createdDate = null,
    Object? deadline = null,
    Object? leaderId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
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
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyGroupImplCopyWith<$Res>
    implements $StudyGroupCopyWith<$Res> {
  factory _$$StudyGroupImplCopyWith(
          _$StudyGroupImpl value, $Res Function(_$StudyGroupImpl) then) =
      __$$StudyGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'team_name') String teamName,
      int max,
      @JsonKey(name: 'headcount') int headCount,
      int isPrivate,
      int isFinished,
      String password,
      String explanation,
      @JsonKey(name: 'created_date') String createdDate,
      String deadline,
      @JsonKey(name: 'leader_id') int leaderId});
}

/// @nodoc
class __$$StudyGroupImplCopyWithImpl<$Res>
    extends _$StudyGroupCopyWithImpl<$Res, _$StudyGroupImpl>
    implements _$$StudyGroupImplCopyWith<$Res> {
  __$$StudyGroupImplCopyWithImpl(
      _$StudyGroupImpl _value, $Res Function(_$StudyGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teamName = null,
    Object? max = null,
    Object? headCount = null,
    Object? isPrivate = null,
    Object? isFinished = null,
    Object? password = null,
    Object? explanation = null,
    Object? createdDate = null,
    Object? deadline = null,
    Object? leaderId = null,
  }) {
    return _then(_$StudyGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
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
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyGroupImpl implements _StudyGroup {
  const _$StudyGroupImpl(
      {required this.id,
      @JsonKey(name: 'team_name') required this.teamName,
      required this.max,
      @JsonKey(name: 'headcount') required this.headCount,
      required this.isPrivate,
      required this.isFinished,
      required this.password,
      required this.explanation,
      @JsonKey(name: 'created_date') required this.createdDate,
      required this.deadline,
      @JsonKey(name: 'leader_id') required this.leaderId});

  factory _$StudyGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyGroupImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'team_name')
  final String teamName;
  @override
  final int max;
  @override
  @JsonKey(name: 'headcount')
  final int headCount;
  @override
  final int isPrivate;
  @override
  final int isFinished;
  @override
  final String password;
  @override
  final String explanation;
  @override
  @JsonKey(name: 'created_date')
  final String createdDate;
  @override
  final String deadline;
  @override
  @JsonKey(name: 'leader_id')
  final int leaderId;

  @override
  String toString() {
    return 'StudyGroup(id: $id, teamName: $teamName, max: $max, headCount: $headCount, isPrivate: $isPrivate, isFinished: $isFinished, password: $password, explanation: $explanation, createdDate: $createdDate, deadline: $deadline, leaderId: $leaderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.headCount, headCount) ||
                other.headCount == headCount) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.leaderId, leaderId) ||
                other.leaderId == leaderId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      teamName,
      max,
      headCount,
      isPrivate,
      isFinished,
      password,
      explanation,
      createdDate,
      deadline,
      leaderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyGroupImplCopyWith<_$StudyGroupImpl> get copyWith =>
      __$$StudyGroupImplCopyWithImpl<_$StudyGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyGroupImplToJson(
      this,
    );
  }
}

abstract class _StudyGroup implements StudyGroup {
  const factory _StudyGroup(
          {required final int id,
          @JsonKey(name: 'team_name') required final String teamName,
          required final int max,
          @JsonKey(name: 'headcount') required final int headCount,
          required final int isPrivate,
          required final int isFinished,
          required final String password,
          required final String explanation,
          @JsonKey(name: 'created_date') required final String createdDate,
          required final String deadline,
          @JsonKey(name: 'leader_id') required final int leaderId}) =
      _$StudyGroupImpl;

  factory _StudyGroup.fromJson(Map<String, dynamic> json) =
      _$StudyGroupImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'team_name')
  String get teamName;
  @override
  int get max;
  @override
  @JsonKey(name: 'headcount')
  int get headCount;
  @override
  int get isPrivate;
  @override
  int get isFinished;
  @override
  String get password;
  @override
  String get explanation;
  @override
  @JsonKey(name: 'created_date')
  String get createdDate;
  @override
  String get deadline;
  @override
  @JsonKey(name: 'leader_id')
  int get leaderId;
  @override
  @JsonKey(ignore: true)
  _$$StudyGroupImplCopyWith<_$StudyGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
