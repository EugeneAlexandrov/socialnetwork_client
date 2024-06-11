// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_post_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DetailPostState _$DetailPostStateFromJson(Map<String, dynamic> json) {
  return _DetailPostState.fromJson(json);
}

/// @nodoc
mixin _$DetailPostState {
  @JsonKey(includeFromJson: false, includeToJson: false)
  AsyncSnapshot<dynamic> get asyncSnapshot =>
      throw _privateConstructorUsedError;
  PostEntity? get post => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailPostStateCopyWith<DetailPostState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailPostStateCopyWith<$Res> {
  factory $DetailPostStateCopyWith(
          DetailPostState value, $Res Function(DetailPostState) then) =
      _$DetailPostStateCopyWithImpl<$Res, DetailPostState>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      AsyncSnapshot<dynamic> asyncSnapshot,
      PostEntity? post});

  $PostEntityCopyWith<$Res>? get post;
}

/// @nodoc
class _$DetailPostStateCopyWithImpl<$Res, $Val extends DetailPostState>
    implements $DetailPostStateCopyWith<$Res> {
  _$DetailPostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asyncSnapshot = null,
    Object? post = freezed,
  }) {
    return _then(_value.copyWith(
      asyncSnapshot: null == asyncSnapshot
          ? _value.asyncSnapshot
          : asyncSnapshot // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<dynamic>,
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as PostEntity?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PostEntityCopyWith<$Res>? get post {
    if (_value.post == null) {
      return null;
    }

    return $PostEntityCopyWith<$Res>(_value.post!, (value) {
      return _then(_value.copyWith(post: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailPostStateImplCopyWith<$Res>
    implements $DetailPostStateCopyWith<$Res> {
  factory _$$DetailPostStateImplCopyWith(_$DetailPostStateImpl value,
          $Res Function(_$DetailPostStateImpl) then) =
      __$$DetailPostStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      AsyncSnapshot<dynamic> asyncSnapshot,
      PostEntity? post});

  @override
  $PostEntityCopyWith<$Res>? get post;
}

/// @nodoc
class __$$DetailPostStateImplCopyWithImpl<$Res>
    extends _$DetailPostStateCopyWithImpl<$Res, _$DetailPostStateImpl>
    implements _$$DetailPostStateImplCopyWith<$Res> {
  __$$DetailPostStateImplCopyWithImpl(
      _$DetailPostStateImpl _value, $Res Function(_$DetailPostStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asyncSnapshot = null,
    Object? post = freezed,
  }) {
    return _then(_$DetailPostStateImpl(
      asyncSnapshot: null == asyncSnapshot
          ? _value.asyncSnapshot
          : asyncSnapshot // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<dynamic>,
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as PostEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailPostStateImpl extends _DetailPostState {
  const _$DetailPostStateImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      this.asyncSnapshot = const AsyncSnapshot.nothing(),
      this.post})
      : super._();

  factory _$DetailPostStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailPostStateImplFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final AsyncSnapshot<dynamic> asyncSnapshot;
  @override
  final PostEntity? post;

  @override
  String toString() {
    return 'DetailPostState(asyncSnapshot: $asyncSnapshot, post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailPostStateImpl &&
            (identical(other.asyncSnapshot, asyncSnapshot) ||
                other.asyncSnapshot == asyncSnapshot) &&
            (identical(other.post, post) || other.post == post));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, asyncSnapshot, post);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailPostStateImplCopyWith<_$DetailPostStateImpl> get copyWith =>
      __$$DetailPostStateImplCopyWithImpl<_$DetailPostStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailPostStateImplToJson(
      this,
    );
  }
}

abstract class _DetailPostState extends DetailPostState {
  const factory _DetailPostState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final AsyncSnapshot<dynamic> asyncSnapshot,
      final PostEntity? post}) = _$DetailPostStateImpl;
  const _DetailPostState._() : super._();

  factory _DetailPostState.fromJson(Map<String, dynamic> json) =
      _$DetailPostStateImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  AsyncSnapshot<dynamic> get asyncSnapshot;
  @override
  PostEntity? get post;
  @override
  @JsonKey(ignore: true)
  _$$DetailPostStateImplCopyWith<_$DetailPostStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
