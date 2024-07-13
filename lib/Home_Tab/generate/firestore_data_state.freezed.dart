// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FirestoreDataState {
  Map<String, List<QueryDocumentSnapshot<Object?>>> get data =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FirestoreDataStateCopyWith<FirestoreDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreDataStateCopyWith<$Res> {
  factory $FirestoreDataStateCopyWith(
          FirestoreDataState value, $Res Function(FirestoreDataState) then) =
      _$FirestoreDataStateCopyWithImpl<$Res, FirestoreDataState>;
  @useResult
  $Res call({Map<String, List<QueryDocumentSnapshot<Object?>>> data});
}

/// @nodoc
class _$FirestoreDataStateCopyWithImpl<$Res, $Val extends FirestoreDataState>
    implements $FirestoreDataStateCopyWith<$Res> {
  _$FirestoreDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, List<QueryDocumentSnapshot<Object?>>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirestoreDataStateImplCopyWith<$Res>
    implements $FirestoreDataStateCopyWith<$Res> {
  factory _$$FirestoreDataStateImplCopyWith(_$FirestoreDataStateImpl value,
          $Res Function(_$FirestoreDataStateImpl) then) =
      __$$FirestoreDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, List<QueryDocumentSnapshot<Object?>>> data});
}

/// @nodoc
class __$$FirestoreDataStateImplCopyWithImpl<$Res>
    extends _$FirestoreDataStateCopyWithImpl<$Res, _$FirestoreDataStateImpl>
    implements _$$FirestoreDataStateImplCopyWith<$Res> {
  __$$FirestoreDataStateImplCopyWithImpl(_$FirestoreDataStateImpl _value,
      $Res Function(_$FirestoreDataStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$FirestoreDataStateImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, List<QueryDocumentSnapshot<Object?>>>,
    ));
  }
}

/// @nodoc

class _$FirestoreDataStateImpl implements _FirestoreDataState {
  const _$FirestoreDataStateImpl(
      {final Map<String, List<QueryDocumentSnapshot<Object?>>> data = const {}})
      : _data = data;

  final Map<String, List<QueryDocumentSnapshot<Object?>>> _data;
  @override
  @JsonKey()
  Map<String, List<QueryDocumentSnapshot<Object?>>> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'FirestoreDataState(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirestoreDataStateImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirestoreDataStateImplCopyWith<_$FirestoreDataStateImpl> get copyWith =>
      __$$FirestoreDataStateImplCopyWithImpl<_$FirestoreDataStateImpl>(
          this, _$identity);
}

abstract class _FirestoreDataState implements FirestoreDataState {
  const factory _FirestoreDataState(
          {final Map<String, List<QueryDocumentSnapshot<Object?>>> data}) =
      _$FirestoreDataStateImpl;

  @override
  Map<String, List<QueryDocumentSnapshot<Object?>>> get data;
  @override
  @JsonKey(ignore: true)
  _$$FirestoreDataStateImplCopyWith<_$FirestoreDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
