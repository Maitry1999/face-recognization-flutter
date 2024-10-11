// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  bool get isPunchIn => throw _privateConstructorUsedError;
  EmployeeAttandanceHelper get employeeAttendance =>
      throw _privateConstructorUsedError;
  List<EmployeeAttendance> get todaysEmployeePunch =>
      throw _privateConstructorUsedError;
  List<Map<String, List<EmployeeAttendance>>> get employeePunchHistory =>
      throw _privateConstructorUsedError;
  LocalAuthentication get auth => throw _privateConstructorUsedError;
  SupportState get supportState => throw _privateConstructorUsedError;
  List<BiometricType> get availableBiometrics =>
      throw _privateConstructorUsedError;
  String get authorized => throw _privateConstructorUsedError;
  String get currentTime => throw _privateConstructorUsedError;
  bool get isAuthenticating => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, Unit>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {bool isPunchIn,
      EmployeeAttandanceHelper employeeAttendance,
      List<EmployeeAttendance> todaysEmployeePunch,
      List<Map<String, List<EmployeeAttendance>>> employeePunchHistory,
      LocalAuthentication auth,
      SupportState supportState,
      List<BiometricType> availableBiometrics,
      String authorized,
      String currentTime,
      bool isAuthenticating,
      Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPunchIn = null,
    Object? employeeAttendance = null,
    Object? todaysEmployeePunch = null,
    Object? employeePunchHistory = null,
    Object? auth = null,
    Object? supportState = null,
    Object? availableBiometrics = null,
    Object? authorized = null,
    Object? currentTime = null,
    Object? isAuthenticating = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      isPunchIn: null == isPunchIn
          ? _value.isPunchIn
          : isPunchIn // ignore: cast_nullable_to_non_nullable
              as bool,
      employeeAttendance: null == employeeAttendance
          ? _value.employeeAttendance
          : employeeAttendance // ignore: cast_nullable_to_non_nullable
              as EmployeeAttandanceHelper,
      todaysEmployeePunch: null == todaysEmployeePunch
          ? _value.todaysEmployeePunch
          : todaysEmployeePunch // ignore: cast_nullable_to_non_nullable
              as List<EmployeeAttendance>,
      employeePunchHistory: null == employeePunchHistory
          ? _value.employeePunchHistory
          : employeePunchHistory // ignore: cast_nullable_to_non_nullable
              as List<Map<String, List<EmployeeAttendance>>>,
      auth: null == auth
          ? _value.auth
          : auth // ignore: cast_nullable_to_non_nullable
              as LocalAuthentication,
      supportState: null == supportState
          ? _value.supportState
          : supportState // ignore: cast_nullable_to_non_nullable
              as SupportState,
      availableBiometrics: null == availableBiometrics
          ? _value.availableBiometrics
          : availableBiometrics // ignore: cast_nullable_to_non_nullable
              as List<BiometricType>,
      authorized: null == authorized
          ? _value.authorized
          : authorized // ignore: cast_nullable_to_non_nullable
              as String,
      currentTime: null == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as String,
      isAuthenticating: null == isAuthenticating
          ? _value.isAuthenticating
          : isAuthenticating // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Unit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPunchIn,
      EmployeeAttandanceHelper employeeAttendance,
      List<EmployeeAttendance> todaysEmployeePunch,
      List<Map<String, List<EmployeeAttendance>>> employeePunchHistory,
      LocalAuthentication auth,
      SupportState supportState,
      List<BiometricType> availableBiometrics,
      String authorized,
      String currentTime,
      bool isAuthenticating,
      Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPunchIn = null,
    Object? employeeAttendance = null,
    Object? todaysEmployeePunch = null,
    Object? employeePunchHistory = null,
    Object? auth = null,
    Object? supportState = null,
    Object? availableBiometrics = null,
    Object? authorized = null,
    Object? currentTime = null,
    Object? isAuthenticating = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$HomeStateImpl(
      isPunchIn: null == isPunchIn
          ? _value.isPunchIn
          : isPunchIn // ignore: cast_nullable_to_non_nullable
              as bool,
      employeeAttendance: null == employeeAttendance
          ? _value.employeeAttendance
          : employeeAttendance // ignore: cast_nullable_to_non_nullable
              as EmployeeAttandanceHelper,
      todaysEmployeePunch: null == todaysEmployeePunch
          ? _value._todaysEmployeePunch
          : todaysEmployeePunch // ignore: cast_nullable_to_non_nullable
              as List<EmployeeAttendance>,
      employeePunchHistory: null == employeePunchHistory
          ? _value._employeePunchHistory
          : employeePunchHistory // ignore: cast_nullable_to_non_nullable
              as List<Map<String, List<EmployeeAttendance>>>,
      auth: null == auth
          ? _value.auth
          : auth // ignore: cast_nullable_to_non_nullable
              as LocalAuthentication,
      supportState: null == supportState
          ? _value.supportState
          : supportState // ignore: cast_nullable_to_non_nullable
              as SupportState,
      availableBiometrics: null == availableBiometrics
          ? _value._availableBiometrics
          : availableBiometrics // ignore: cast_nullable_to_non_nullable
              as List<BiometricType>,
      authorized: null == authorized
          ? _value.authorized
          : authorized // ignore: cast_nullable_to_non_nullable
              as String,
      currentTime: null == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as String,
      isAuthenticating: null == isAuthenticating
          ? _value.isAuthenticating
          : isAuthenticating // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Unit>>,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  _$HomeStateImpl(
      {required this.isPunchIn,
      required this.employeeAttendance,
      required final List<EmployeeAttendance> todaysEmployeePunch,
      required final List<Map<String, List<EmployeeAttendance>>>
          employeePunchHistory,
      required this.auth,
      required this.supportState,
      required final List<BiometricType> availableBiometrics,
      required this.authorized,
      required this.currentTime,
      required this.isAuthenticating,
      required this.authFailureOrSuccessOption})
      : _todaysEmployeePunch = todaysEmployeePunch,
        _employeePunchHistory = employeePunchHistory,
        _availableBiometrics = availableBiometrics;

  @override
  final bool isPunchIn;
  @override
  final EmployeeAttandanceHelper employeeAttendance;
  final List<EmployeeAttendance> _todaysEmployeePunch;
  @override
  List<EmployeeAttendance> get todaysEmployeePunch {
    if (_todaysEmployeePunch is EqualUnmodifiableListView)
      return _todaysEmployeePunch;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todaysEmployeePunch);
  }

  final List<Map<String, List<EmployeeAttendance>>> _employeePunchHistory;
  @override
  List<Map<String, List<EmployeeAttendance>>> get employeePunchHistory {
    if (_employeePunchHistory is EqualUnmodifiableListView)
      return _employeePunchHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employeePunchHistory);
  }

  @override
  final LocalAuthentication auth;
  @override
  final SupportState supportState;
  final List<BiometricType> _availableBiometrics;
  @override
  List<BiometricType> get availableBiometrics {
    if (_availableBiometrics is EqualUnmodifiableListView)
      return _availableBiometrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableBiometrics);
  }

  @override
  final String authorized;
  @override
  final String currentTime;
  @override
  final bool isAuthenticating;
  @override
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'HomeState(isPunchIn: $isPunchIn, employeeAttendance: $employeeAttendance, todaysEmployeePunch: $todaysEmployeePunch, employeePunchHistory: $employeePunchHistory, auth: $auth, supportState: $supportState, availableBiometrics: $availableBiometrics, authorized: $authorized, currentTime: $currentTime, isAuthenticating: $isAuthenticating, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.isPunchIn, isPunchIn) ||
                other.isPunchIn == isPunchIn) &&
            (identical(other.employeeAttendance, employeeAttendance) ||
                other.employeeAttendance == employeeAttendance) &&
            const DeepCollectionEquality()
                .equals(other._todaysEmployeePunch, _todaysEmployeePunch) &&
            const DeepCollectionEquality()
                .equals(other._employeePunchHistory, _employeePunchHistory) &&
            (identical(other.auth, auth) || other.auth == auth) &&
            (identical(other.supportState, supportState) ||
                other.supportState == supportState) &&
            const DeepCollectionEquality()
                .equals(other._availableBiometrics, _availableBiometrics) &&
            (identical(other.authorized, authorized) ||
                other.authorized == authorized) &&
            (identical(other.currentTime, currentTime) ||
                other.currentTime == currentTime) &&
            (identical(other.isAuthenticating, isAuthenticating) ||
                other.isAuthenticating == isAuthenticating) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isPunchIn,
      employeeAttendance,
      const DeepCollectionEquality().hash(_todaysEmployeePunch),
      const DeepCollectionEquality().hash(_employeePunchHistory),
      auth,
      supportState,
      const DeepCollectionEquality().hash(_availableBiometrics),
      authorized,
      currentTime,
      isAuthenticating,
      authFailureOrSuccessOption);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {required final bool isPunchIn,
      required final EmployeeAttandanceHelper employeeAttendance,
      required final List<EmployeeAttendance> todaysEmployeePunch,
      required final List<Map<String, List<EmployeeAttendance>>>
          employeePunchHistory,
      required final LocalAuthentication auth,
      required final SupportState supportState,
      required final List<BiometricType> availableBiometrics,
      required final String authorized,
      required final String currentTime,
      required final bool isAuthenticating,
      required final Option<Either<AuthFailure, Unit>>
          authFailureOrSuccessOption}) = _$HomeStateImpl;

  @override
  bool get isPunchIn;
  @override
  EmployeeAttandanceHelper get employeeAttendance;
  @override
  List<EmployeeAttendance> get todaysEmployeePunch;
  @override
  List<Map<String, List<EmployeeAttendance>>> get employeePunchHistory;
  @override
  LocalAuthentication get auth;
  @override
  SupportState get supportState;
  @override
  List<BiometricType> get availableBiometrics;
  @override
  String get authorized;
  @override
  String get currentTime;
  @override
  bool get isAuthenticating;
  @override
  Option<Either<AuthFailure, Unit>> get authFailureOrSuccessOption;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initEvent,
    required TResult Function(BuildContext context) punchInOut,
    required TResult Function() loadTodaysEmployeePunch,
    required TResult Function() loadEmployeePunchHistory,
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initEvent,
    TResult? Function(BuildContext context)? punchInOut,
    TResult? Function()? loadTodaysEmployeePunch,
    TResult? Function()? loadEmployeePunchHistory,
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initEvent,
    TResult Function(BuildContext context)? punchInOut,
    TResult Function()? loadTodaysEmployeePunch,
    TResult Function()? loadEmployeePunchHistory,
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitEvent value) initEvent,
    required TResult Function(PunchInOut value) punchInOut,
    required TResult Function(LoadTodaysEmployeePunch value)
        loadTodaysEmployeePunch,
    required TResult Function(LoadEmployeePunchHistory value)
        loadEmployeePunchHistory,
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitEvent value)? initEvent,
    TResult? Function(PunchInOut value)? punchInOut,
    TResult? Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult? Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitEvent value)? initEvent,
    TResult Function(PunchInOut value)? punchInOut,
    TResult Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEventCopyWith<$Res> {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) then) =
      _$HomeEventCopyWithImpl<$Res, HomeEvent>;
}

/// @nodoc
class _$HomeEventCopyWithImpl<$Res, $Val extends HomeEvent>
    implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitEventImplCopyWith<$Res> {
  factory _$$InitEventImplCopyWith(
          _$InitEventImpl value, $Res Function(_$InitEventImpl) then) =
      __$$InitEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitEventImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$InitEventImpl>
    implements _$$InitEventImplCopyWith<$Res> {
  __$$InitEventImplCopyWithImpl(
      _$InitEventImpl _value, $Res Function(_$InitEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitEventImpl implements InitEvent {
  const _$InitEventImpl();

  @override
  String toString() {
    return 'HomeEvent.initEvent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initEvent,
    required TResult Function(BuildContext context) punchInOut,
    required TResult Function() loadTodaysEmployeePunch,
    required TResult Function() loadEmployeePunchHistory,
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return initEvent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initEvent,
    TResult? Function(BuildContext context)? punchInOut,
    TResult? Function()? loadTodaysEmployeePunch,
    TResult? Function()? loadEmployeePunchHistory,
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return initEvent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initEvent,
    TResult Function(BuildContext context)? punchInOut,
    TResult Function()? loadTodaysEmployeePunch,
    TResult Function()? loadEmployeePunchHistory,
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (initEvent != null) {
      return initEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitEvent value) initEvent,
    required TResult Function(PunchInOut value) punchInOut,
    required TResult Function(LoadTodaysEmployeePunch value)
        loadTodaysEmployeePunch,
    required TResult Function(LoadEmployeePunchHistory value)
        loadEmployeePunchHistory,
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return initEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitEvent value)? initEvent,
    TResult? Function(PunchInOut value)? punchInOut,
    TResult? Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult? Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return initEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitEvent value)? initEvent,
    TResult Function(PunchInOut value)? punchInOut,
    TResult Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (initEvent != null) {
      return initEvent(this);
    }
    return orElse();
  }
}

abstract class InitEvent implements HomeEvent {
  const factory InitEvent() = _$InitEventImpl;
}

/// @nodoc
abstract class _$$PunchInOutImplCopyWith<$Res> {
  factory _$$PunchInOutImplCopyWith(
          _$PunchInOutImpl value, $Res Function(_$PunchInOutImpl) then) =
      __$$PunchInOutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BuildContext context});
}

/// @nodoc
class __$$PunchInOutImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$PunchInOutImpl>
    implements _$$PunchInOutImplCopyWith<$Res> {
  __$$PunchInOutImplCopyWithImpl(
      _$PunchInOutImpl _value, $Res Function(_$PunchInOutImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
  }) {
    return _then(_$PunchInOutImpl(
      null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$PunchInOutImpl implements PunchInOut {
  const _$PunchInOutImpl(this.context);

  @override
  final BuildContext context;

  @override
  String toString() {
    return 'HomeEvent.punchInOut(context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PunchInOutImpl &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PunchInOutImplCopyWith<_$PunchInOutImpl> get copyWith =>
      __$$PunchInOutImplCopyWithImpl<_$PunchInOutImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initEvent,
    required TResult Function(BuildContext context) punchInOut,
    required TResult Function() loadTodaysEmployeePunch,
    required TResult Function() loadEmployeePunchHistory,
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return punchInOut(context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initEvent,
    TResult? Function(BuildContext context)? punchInOut,
    TResult? Function()? loadTodaysEmployeePunch,
    TResult? Function()? loadEmployeePunchHistory,
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return punchInOut?.call(context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initEvent,
    TResult Function(BuildContext context)? punchInOut,
    TResult Function()? loadTodaysEmployeePunch,
    TResult Function()? loadEmployeePunchHistory,
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (punchInOut != null) {
      return punchInOut(context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitEvent value) initEvent,
    required TResult Function(PunchInOut value) punchInOut,
    required TResult Function(LoadTodaysEmployeePunch value)
        loadTodaysEmployeePunch,
    required TResult Function(LoadEmployeePunchHistory value)
        loadEmployeePunchHistory,
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return punchInOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitEvent value)? initEvent,
    TResult? Function(PunchInOut value)? punchInOut,
    TResult? Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult? Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return punchInOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitEvent value)? initEvent,
    TResult Function(PunchInOut value)? punchInOut,
    TResult Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (punchInOut != null) {
      return punchInOut(this);
    }
    return orElse();
  }
}

abstract class PunchInOut implements HomeEvent {
  const factory PunchInOut(final BuildContext context) = _$PunchInOutImpl;

  BuildContext get context;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PunchInOutImplCopyWith<_$PunchInOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadTodaysEmployeePunchImplCopyWith<$Res> {
  factory _$$LoadTodaysEmployeePunchImplCopyWith(
          _$LoadTodaysEmployeePunchImpl value,
          $Res Function(_$LoadTodaysEmployeePunchImpl) then) =
      __$$LoadTodaysEmployeePunchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadTodaysEmployeePunchImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$LoadTodaysEmployeePunchImpl>
    implements _$$LoadTodaysEmployeePunchImplCopyWith<$Res> {
  __$$LoadTodaysEmployeePunchImplCopyWithImpl(
      _$LoadTodaysEmployeePunchImpl _value,
      $Res Function(_$LoadTodaysEmployeePunchImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadTodaysEmployeePunchImpl implements LoadTodaysEmployeePunch {
  const _$LoadTodaysEmployeePunchImpl();

  @override
  String toString() {
    return 'HomeEvent.loadTodaysEmployeePunch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTodaysEmployeePunchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initEvent,
    required TResult Function(BuildContext context) punchInOut,
    required TResult Function() loadTodaysEmployeePunch,
    required TResult Function() loadEmployeePunchHistory,
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return loadTodaysEmployeePunch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initEvent,
    TResult? Function(BuildContext context)? punchInOut,
    TResult? Function()? loadTodaysEmployeePunch,
    TResult? Function()? loadEmployeePunchHistory,
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return loadTodaysEmployeePunch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initEvent,
    TResult Function(BuildContext context)? punchInOut,
    TResult Function()? loadTodaysEmployeePunch,
    TResult Function()? loadEmployeePunchHistory,
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (loadTodaysEmployeePunch != null) {
      return loadTodaysEmployeePunch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitEvent value) initEvent,
    required TResult Function(PunchInOut value) punchInOut,
    required TResult Function(LoadTodaysEmployeePunch value)
        loadTodaysEmployeePunch,
    required TResult Function(LoadEmployeePunchHistory value)
        loadEmployeePunchHistory,
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return loadTodaysEmployeePunch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitEvent value)? initEvent,
    TResult? Function(PunchInOut value)? punchInOut,
    TResult? Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult? Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return loadTodaysEmployeePunch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitEvent value)? initEvent,
    TResult Function(PunchInOut value)? punchInOut,
    TResult Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (loadTodaysEmployeePunch != null) {
      return loadTodaysEmployeePunch(this);
    }
    return orElse();
  }
}

abstract class LoadTodaysEmployeePunch implements HomeEvent {
  const factory LoadTodaysEmployeePunch() = _$LoadTodaysEmployeePunchImpl;
}

/// @nodoc
abstract class _$$LoadEmployeePunchHistoryImplCopyWith<$Res> {
  factory _$$LoadEmployeePunchHistoryImplCopyWith(
          _$LoadEmployeePunchHistoryImpl value,
          $Res Function(_$LoadEmployeePunchHistoryImpl) then) =
      __$$LoadEmployeePunchHistoryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadEmployeePunchHistoryImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$LoadEmployeePunchHistoryImpl>
    implements _$$LoadEmployeePunchHistoryImplCopyWith<$Res> {
  __$$LoadEmployeePunchHistoryImplCopyWithImpl(
      _$LoadEmployeePunchHistoryImpl _value,
      $Res Function(_$LoadEmployeePunchHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadEmployeePunchHistoryImpl implements LoadEmployeePunchHistory {
  const _$LoadEmployeePunchHistoryImpl();

  @override
  String toString() {
    return 'HomeEvent.loadEmployeePunchHistory()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadEmployeePunchHistoryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initEvent,
    required TResult Function(BuildContext context) punchInOut,
    required TResult Function() loadTodaysEmployeePunch,
    required TResult Function() loadEmployeePunchHistory,
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return loadEmployeePunchHistory();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initEvent,
    TResult? Function(BuildContext context)? punchInOut,
    TResult? Function()? loadTodaysEmployeePunch,
    TResult? Function()? loadEmployeePunchHistory,
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return loadEmployeePunchHistory?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initEvent,
    TResult Function(BuildContext context)? punchInOut,
    TResult Function()? loadTodaysEmployeePunch,
    TResult Function()? loadEmployeePunchHistory,
    TResult Function()? getCurrentTime,
    TResult Function()? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (loadEmployeePunchHistory != null) {
      return loadEmployeePunchHistory();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitEvent value) initEvent,
    required TResult Function(PunchInOut value) punchInOut,
    required TResult Function(LoadTodaysEmployeePunch value)
        loadTodaysEmployeePunch,
    required TResult Function(LoadEmployeePunchHistory value)
        loadEmployeePunchHistory,
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return loadEmployeePunchHistory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitEvent value)? initEvent,
    TResult? Function(PunchInOut value)? punchInOut,
    TResult? Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult? Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return loadEmployeePunchHistory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitEvent value)? initEvent,
    TResult Function(PunchInOut value)? punchInOut,
    TResult Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult Function(GetCurrentTime value)? getCurrentTime,
    TResult Function(UpdateCurrentTime value)? updateCurrentTime,
    required TResult orElse(),
  }) {
    if (loadEmployeePunchHistory != null) {
      return loadEmployeePunchHistory(this);
    }
    return orElse();
  }
}

abstract class LoadEmployeePunchHistory implements HomeEvent {
  const factory LoadEmployeePunchHistory() = _$LoadEmployeePunchHistoryImpl;
}

/// @nodoc
abstract class _$$GetCurrentTimeImplCopyWith<$Res> {
  factory _$$GetCurrentTimeImplCopyWith(_$GetCurrentTimeImpl value,
          $Res Function(_$GetCurrentTimeImpl) then) =
      __$$GetCurrentTimeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetCurrentTimeImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$GetCurrentTimeImpl>
    implements _$$GetCurrentTimeImplCopyWith<$Res> {
  __$$GetCurrentTimeImplCopyWithImpl(
      _$GetCurrentTimeImpl _value, $Res Function(_$GetCurrentTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetCurrentTimeImpl implements GetCurrentTime {
  const _$GetCurrentTimeImpl();

  @override
  String toString() {
    return 'HomeEvent.getCurrentTime()';
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
    required TResult Function() initEvent,
    required TResult Function(BuildContext context) punchInOut,
    required TResult Function() loadTodaysEmployeePunch,
    required TResult Function() loadEmployeePunchHistory,
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return getCurrentTime();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initEvent,
    TResult? Function(BuildContext context)? punchInOut,
    TResult? Function()? loadTodaysEmployeePunch,
    TResult? Function()? loadEmployeePunchHistory,
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return getCurrentTime?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initEvent,
    TResult Function(BuildContext context)? punchInOut,
    TResult Function()? loadTodaysEmployeePunch,
    TResult Function()? loadEmployeePunchHistory,
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
    required TResult Function(InitEvent value) initEvent,
    required TResult Function(PunchInOut value) punchInOut,
    required TResult Function(LoadTodaysEmployeePunch value)
        loadTodaysEmployeePunch,
    required TResult Function(LoadEmployeePunchHistory value)
        loadEmployeePunchHistory,
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return getCurrentTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitEvent value)? initEvent,
    TResult? Function(PunchInOut value)? punchInOut,
    TResult? Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult? Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return getCurrentTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitEvent value)? initEvent,
    TResult Function(PunchInOut value)? punchInOut,
    TResult Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
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

abstract class GetCurrentTime implements HomeEvent {
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
    extends _$HomeEventCopyWithImpl<$Res, _$UpdateCurrentTimeImpl>
    implements _$$UpdateCurrentTimeImplCopyWith<$Res> {
  __$$UpdateCurrentTimeImplCopyWithImpl(_$UpdateCurrentTimeImpl _value,
      $Res Function(_$UpdateCurrentTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateCurrentTimeImpl implements UpdateCurrentTime {
  const _$UpdateCurrentTimeImpl();

  @override
  String toString() {
    return 'HomeEvent.updateCurrentTime()';
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
    required TResult Function() initEvent,
    required TResult Function(BuildContext context) punchInOut,
    required TResult Function() loadTodaysEmployeePunch,
    required TResult Function() loadEmployeePunchHistory,
    required TResult Function() getCurrentTime,
    required TResult Function() updateCurrentTime,
  }) {
    return updateCurrentTime();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initEvent,
    TResult? Function(BuildContext context)? punchInOut,
    TResult? Function()? loadTodaysEmployeePunch,
    TResult? Function()? loadEmployeePunchHistory,
    TResult? Function()? getCurrentTime,
    TResult? Function()? updateCurrentTime,
  }) {
    return updateCurrentTime?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initEvent,
    TResult Function(BuildContext context)? punchInOut,
    TResult Function()? loadTodaysEmployeePunch,
    TResult Function()? loadEmployeePunchHistory,
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
    required TResult Function(InitEvent value) initEvent,
    required TResult Function(PunchInOut value) punchInOut,
    required TResult Function(LoadTodaysEmployeePunch value)
        loadTodaysEmployeePunch,
    required TResult Function(LoadEmployeePunchHistory value)
        loadEmployeePunchHistory,
    required TResult Function(GetCurrentTime value) getCurrentTime,
    required TResult Function(UpdateCurrentTime value) updateCurrentTime,
  }) {
    return updateCurrentTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitEvent value)? initEvent,
    TResult? Function(PunchInOut value)? punchInOut,
    TResult? Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult? Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
    TResult? Function(GetCurrentTime value)? getCurrentTime,
    TResult? Function(UpdateCurrentTime value)? updateCurrentTime,
  }) {
    return updateCurrentTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitEvent value)? initEvent,
    TResult Function(PunchInOut value)? punchInOut,
    TResult Function(LoadTodaysEmployeePunch value)? loadTodaysEmployeePunch,
    TResult Function(LoadEmployeePunchHistory value)? loadEmployeePunchHistory,
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

abstract class UpdateCurrentTime implements HomeEvent {
  const factory UpdateCurrentTime() = _$UpdateCurrentTimeImpl;
}
