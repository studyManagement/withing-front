// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_vote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleVoteModel _$ScheduleVoteModelFromJson(Map<String, dynamic> json) {
  return _ScheduleVoteModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleVoteModel {
  int get id => throw _privateConstructorUsedError;
  int get studyId => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<ScheduleVoteItemModel> get votes => throw _privateConstructorUsedError;
  DateTime get cratedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleVoteModelCopyWith<ScheduleVoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleVoteModelCopyWith<$Res> {
  factory $ScheduleVoteModelCopyWith(
          ScheduleVoteModel value, $Res Function(ScheduleVoteModel) then) =
      _$ScheduleVoteModelCopyWithImpl<$Res, ScheduleVoteModel>;
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      String title,
      String description,
      List<ScheduleVoteItemModel> votes,
      DateTime cratedAt});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$ScheduleVoteModelCopyWithImpl<$Res, $Val extends ScheduleVoteModel>
    implements $ScheduleVoteModelCopyWith<$Res> {
  _$ScheduleVoteModelCopyWithImpl(this._value, this._then);

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
    Object? votes = null,
    Object? cratedAt = null,
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
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<ScheduleVoteItemModel>,
      cratedAt: null == cratedAt
          ? _value.cratedAt
          : cratedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ScheduleVoteModelImplCopyWith<$Res>
    implements $ScheduleVoteModelCopyWith<$Res> {
  factory _$$ScheduleVoteModelImplCopyWith(_$ScheduleVoteModelImpl value,
          $Res Function(_$ScheduleVoteModelImpl) then) =
      __$$ScheduleVoteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int studyId,
      UserModel user,
      String title,
      String description,
      List<ScheduleVoteItemModel> votes,
      DateTime cratedAt});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$ScheduleVoteModelImplCopyWithImpl<$Res>
    extends _$ScheduleVoteModelCopyWithImpl<$Res, _$ScheduleVoteModelImpl>
    implements _$$ScheduleVoteModelImplCopyWith<$Res> {
  __$$ScheduleVoteModelImplCopyWithImpl(_$ScheduleVoteModelImpl _value,
      $Res Function(_$ScheduleVoteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyId = null,
    Object? user = null,
    Object? title = null,
    Object? description = null,
    Object? votes = null,
    Object? cratedAt = null,
  }) {
    return _then(_$ScheduleVoteModelImpl(
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
      votes: null == votes
          ? _value._votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<ScheduleVoteItemModel>,
      cratedAt: null == cratedAt
          ? _value.cratedAt
          : cratedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleVoteModelImpl implements _ScheduleVoteModel {
  const _$ScheduleVoteModelImpl(
      {required this.id,
      required this.studyId,
      required this.user,
      required this.title,
      required this.description,
      required final List<ScheduleVoteItemModel> votes,
      required this.cratedAt})
      : _votes = votes;

  factory _$ScheduleVoteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleVoteModelImplFromJson(json);

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
  final List<ScheduleVoteItemModel> _votes;
  @override
  List<ScheduleVoteItemModel> get votes {
    if (_votes is EqualUnmodifiableListView) return _votes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_votes);
  }

  @override
  final DateTime cratedAt;

  @override
  String toString() {
    return 'ScheduleVoteModel(id: $id, studyId: $studyId, user: $user, title: $title, description: $description, votes: $votes, cratedAt: $cratedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleVoteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._votes, _votes) &&
            (identical(other.cratedAt, cratedAt) ||
                other.cratedAt == cratedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, studyId, user, title,
      description, const DeepCollectionEquality().hash(_votes), cratedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleVoteModelImplCopyWith<_$ScheduleVoteModelImpl> get copyWith =>
      __$$ScheduleVoteModelImplCopyWithImpl<_$ScheduleVoteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleVoteModelImplToJson(
      this,
    );
  }
}

abstract class _ScheduleVoteModel implements ScheduleVoteModel {
  const factory _ScheduleVoteModel(
      {required final int id,
      required final int studyId,
      required final UserModel user,
      required final String title,
      required final String description,
      required final List<ScheduleVoteItemModel> votes,
      required final DateTime cratedAt}) = _$ScheduleVoteModelImpl;

  factory _ScheduleVoteModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleVoteModelImpl.fromJson;

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
  List<ScheduleVoteItemModel> get votes;
  @override
  DateTime get cratedAt;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleVoteModelImplCopyWith<_$ScheduleVoteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
