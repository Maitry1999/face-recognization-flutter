// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Account {
  String? get userId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  int? get phone => throw _privateConstructorUsedError;
  List<DateTime>? get punchInOutTime => throw _privateConstructorUsedError;
  bool? get isAdmin => throw _privateConstructorUsedError;
  String? get faceData =>
      throw _privateConstructorUsedError; // New field for storing face data
  String? get boundingBox =>
      throw _privateConstructorUsedError; // New field for storing face data
  List<dynamic>? get predictedData => throw _privateConstructorUsedError;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {String? userId,
      String? firstName,
      String? lastName,
      String? email,
      String? countryCode,
      String? designation,
      String? profileImage,
      int? phone,
      List<DateTime>? punchInOutTime,
      bool? isAdmin,
      String? faceData,
      String? boundingBox,
      List<dynamic>? predictedData});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? countryCode = freezed,
    Object? designation = freezed,
    Object? profileImage = freezed,
    Object? phone = freezed,
    Object? punchInOutTime = freezed,
    Object? isAdmin = freezed,
    Object? faceData = freezed,
    Object? boundingBox = freezed,
    Object? predictedData = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int?,
      punchInOutTime: freezed == punchInOutTime
          ? _value.punchInOutTime
          : punchInOutTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
      faceData: freezed == faceData
          ? _value.faceData
          : faceData // ignore: cast_nullable_to_non_nullable
              as String?,
      boundingBox: freezed == boundingBox
          ? _value.boundingBox
          : boundingBox // ignore: cast_nullable_to_non_nullable
              as String?,
      predictedData: freezed == predictedData
          ? _value.predictedData
          : predictedData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountImplCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$AccountImplCopyWith(
          _$AccountImpl value, $Res Function(_$AccountImpl) then) =
      __$$AccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String? firstName,
      String? lastName,
      String? email,
      String? countryCode,
      String? designation,
      String? profileImage,
      int? phone,
      List<DateTime>? punchInOutTime,
      bool? isAdmin,
      String? faceData,
      String? boundingBox,
      List<dynamic>? predictedData});
}

/// @nodoc
class __$$AccountImplCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$AccountImpl>
    implements _$$AccountImplCopyWith<$Res> {
  __$$AccountImplCopyWithImpl(
      _$AccountImpl _value, $Res Function(_$AccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? countryCode = freezed,
    Object? designation = freezed,
    Object? profileImage = freezed,
    Object? phone = freezed,
    Object? punchInOutTime = freezed,
    Object? isAdmin = freezed,
    Object? faceData = freezed,
    Object? boundingBox = freezed,
    Object? predictedData = freezed,
  }) {
    return _then(_$AccountImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int?,
      punchInOutTime: freezed == punchInOutTime
          ? _value._punchInOutTime
          : punchInOutTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
      faceData: freezed == faceData
          ? _value.faceData
          : faceData // ignore: cast_nullable_to_non_nullable
              as String?,
      boundingBox: freezed == boundingBox
          ? _value.boundingBox
          : boundingBox // ignore: cast_nullable_to_non_nullable
              as String?,
      predictedData: freezed == predictedData
          ? _value._predictedData
          : predictedData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

class _$AccountImpl extends _Account {
  const _$AccountImpl(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.designation,
      this.profileImage,
      this.phone,
      final List<DateTime>? punchInOutTime,
      this.isAdmin,
      this.faceData,
      this.boundingBox,
      final List<dynamic>? predictedData})
      : _punchInOutTime = punchInOutTime,
        _predictedData = predictedData,
        super._();

  @override
  final String? userId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? countryCode;
  @override
  final String? designation;
  @override
  final String? profileImage;
  @override
  final int? phone;
  final List<DateTime>? _punchInOutTime;
  @override
  List<DateTime>? get punchInOutTime {
    final value = _punchInOutTime;
    if (value == null) return null;
    if (_punchInOutTime is EqualUnmodifiableListView) return _punchInOutTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isAdmin;
  @override
  final String? faceData;
// New field for storing face data
  @override
  final String? boundingBox;
// New field for storing face data
  final List<dynamic>? _predictedData;
// New field for storing face data
  @override
  List<dynamic>? get predictedData {
    final value = _predictedData;
    if (value == null) return null;
    if (_predictedData is EqualUnmodifiableListView) return _predictedData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Account(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, countryCode: $countryCode, designation: $designation, profileImage: $profileImage, phone: $phone, punchInOutTime: $punchInOutTime, isAdmin: $isAdmin, faceData: $faceData, boundingBox: $boundingBox, predictedData: $predictedData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            const DeepCollectionEquality()
                .equals(other._punchInOutTime, _punchInOutTime) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.faceData, faceData) ||
                other.faceData == faceData) &&
            (identical(other.boundingBox, boundingBox) ||
                other.boundingBox == boundingBox) &&
            const DeepCollectionEquality()
                .equals(other._predictedData, _predictedData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      firstName,
      lastName,
      email,
      countryCode,
      designation,
      profileImage,
      phone,
      const DeepCollectionEquality().hash(_punchInOutTime),
      isAdmin,
      faceData,
      boundingBox,
      const DeepCollectionEquality().hash(_predictedData));

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      __$$AccountImplCopyWithImpl<_$AccountImpl>(this, _$identity);
}

abstract class _Account extends Account {
  const factory _Account(
      {final String? userId,
      final String? firstName,
      final String? lastName,
      final String? email,
      final String? countryCode,
      final String? designation,
      final String? profileImage,
      final int? phone,
      final List<DateTime>? punchInOutTime,
      final bool? isAdmin,
      final String? faceData,
      final String? boundingBox,
      final List<dynamic>? predictedData}) = _$AccountImpl;
  const _Account._() : super._();

  @override
  String? get userId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get countryCode;
  @override
  String? get designation;
  @override
  String? get profileImage;
  @override
  int? get phone;
  @override
  List<DateTime>? get punchInOutTime;
  @override
  bool? get isAdmin;
  @override
  String? get faceData; // New field for storing face data
  @override
  String? get boundingBox; // New field for storing face data
  @override
  List<dynamic>? get predictedData;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
