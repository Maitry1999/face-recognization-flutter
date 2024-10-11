// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardState {
  bool get isPunchIn => throw _privateConstructorUsedError;
  String get currentTime => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, Unit>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStateCopyWith<DashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
          DashboardState value, $Res Function(DashboardState) then) =
      _$DashboardStateCopyWithImpl<$Res, DashboardState>;
  @useResult
  $Res call(
      {bool isPunchIn,
      String currentTime,
      Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption});
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPunchIn = null,
    Object? currentTime = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      isPunchIn: null == isPunchIn
          ? _value.isPunchIn
          : isPunchIn // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTime: null == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as String,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStateImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateImplCopyWith(_$DashboardStateImpl value,
          $Res Function(_$DashboardStateImpl) then) =
      __$$DashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPunchIn,
      String currentTime,
      Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$DashboardStateImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateImpl>
    implements _$$DashboardStateImplCopyWith<$Res> {
  __$$DashboardStateImplCopyWithImpl(
      _$DashboardStateImpl _value, $Res Function(_$DashboardStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPunchIn = null,
    Object? currentTime = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$DashboardStateImpl(
      isPunchIn: null == isPunchIn
          ? _value.isPunchIn
          : isPunchIn // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTime: null == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as String,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$DashboardStateImpl implements _DashboardState {
  _$DashboardStateImpl(
      {required this.isPunchIn,
      required this.currentTime,
      required this.authFailureOrSuccessOption});

  @override
  final bool isPunchIn;
  @override
  final String currentTime;
  @override
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'DashboardState(isPunchIn: $isPunchIn, currentTime: $currentTime, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateImpl &&
            (identical(other.isPunchIn, isPunchIn) ||
                other.isPunchIn == isPunchIn) &&
            (identical(other.currentTime, currentTime) ||
                other.currentTime == currentTime) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isPunchIn, currentTime, authFailureOrSuccessOption);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      __$$DashboardStateImplCopyWithImpl<_$DashboardStateImpl>(
          this, _$identity);
}

abstract class _DashboardState implements DashboardState {
  factory _DashboardState(
      {required final bool isPunchIn,
      required final String currentTime,
      required final Option<Either<AuthFailure, Unit>>
          authFailureOrSuccessOption}) = _$DashboardStateImpl;

  @override
  bool get isPunchIn;
  @override
  String get currentTime;
  @override
  Option<Either<AuthFailure, Unit>> get authFailureOrSuccessOption;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DashboardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardEventCopyWith<$Res> {
  factory $DashboardEventCopyWith(
          DashboardEvent value, $Res Function(DashboardEvent) then) =
      _$DashboardEventCopyWithImpl<$Res, DashboardEvent>;
}

/// @nodoc
class _$DashboardEventCopyWithImpl<$Res, $Val extends DashboardEvent>
    implements $DashboardEventCopyWith<$Res> {
  _$DashboardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetCurrentTimeImplCopyWith<$Res> {
  factory _$$GetCurrentTimeImplCopyWith(_$GetCurrentTimeImpl value,
          $Res Function(_$GetCurrentTimeImpl) then) =
      __$$GetCurrentTimeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetCurrentTimeImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$GetCurrentTimeImpl>
    implements _$$GetCurrentTimeImplCopyWith<$Res> {
  __$$GetCurrentTimeImplCopyWithImpl(
      _$GetCurrentTimeImpl _value, $Res Function(_$GetCurrentTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetCurrentTimeImpl implements GetCurrentTime {
  const _$GetCurrentTimeImpl();

  @override
  String toString() {
    return 'DashboardEvent.getCurrentTime()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetCurrentTimeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return getCurrentTime();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return getCurrentTime?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (getCurrentTime != null) {
      return getCurrentTime();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return getCurrentTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return getCurrentTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (getCurrentTime != null) {
      return getCurrentTime(this);
    }
    return orElse();
  }
}

abstract class GetCurrentTime implements DashboardEvent {
  const factory GetCurrentTime() = _$GetCurrentTimeImpl;
}

/// @nodoc
abstract class _$$UpdateCurrentTimeImplCopyWith<$Res> {
  factory _$$UpdateCurrentTimeImplCopyWith(_$UpdateCurrentTimeImpl value,
          $Res Function(_$UpdateCurrentTimeImpl) then) =
      __$$UpdateCurrentTimeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateCurrentTimeImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$UpdateCurrentTimeImpl>
    implements _$$UpdateCurrentTimeImplCopyWith<$Res> {
  __$$UpdateCurrentTimeImplCopyWithImpl(_$UpdateCurrentTimeImpl _value,
      $Res Function(_$UpdateCurrentTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateCurrentTimeImpl implements UpdateCurrentTime {
  const _$UpdateCurrentTimeImpl();

  @override
  String toString() {
    return 'DashboardEvent.updateCurrentTime()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateCurrentTimeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return updateCurrentTime();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return updateCurrentTime?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (updateCurrentTime != null) {
      return updateCurrentTime();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return updateCurrentTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return updateCurrentTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (updateCurrentTime != null) {
      return updateCurrentTime(this);
    }
    return orElse();
  }
}

abstract class UpdateCurrentTime implements DashboardEvent {
  const factory UpdateCurrentTime() = _$UpdateCurrentTimeImpl;
}
