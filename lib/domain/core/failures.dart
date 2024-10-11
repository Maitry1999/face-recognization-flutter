import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;

  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

  const factory ValueFailure.tooManyGuilds({
    required T failedValue,
    required int max,
  }) = TooManyGuilds<T>;

  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.invalidUsername({
    required T failedValue,
  }) = InvalidUsername<T>;
  const factory ValueFailure.invalidMobileNumber({
    required T failedValue,
  }) = InvalidMobileNumber<T>;
  const factory ValueFailure.invalidChannelName({
    required T failedValue,
  }) = InvalidChannelName<T>;

  const factory ValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;

  const factory ValueFailure.passwordsDontMatch({
    required T failedValue,
  }) = PasswordsDontMatch<T>;

  const factory ValueFailure.exceedingSize({
    required T failedValue,
    required int max,
  }) = ExceedingSize<T>;

  const factory ValueFailure.invalidColor({
    required T failedValue,
  }) = InvalidColor<T>;

  const factory ValueFailure.invalidUID({
    required T failedValue,
  }) = InvalidUID<T>;

  const factory ValueFailure.invalidCardNumber({
    required T failedValue,
  }) = InvalidCardNumber<T>;

  const factory ValueFailure.invalidaCardMonth({
    required T failedValue,
  }) = InvalidCardMonth<T>;
  const factory ValueFailure.invalidaCardYear({
    required T failedValue,
  }) = InvalidCardYear<T>;
  const factory ValueFailure.cardExpired({
    required T failedValue,
  }) = CardExpired<T>;

  const factory ValueFailure.invalidCvv({
    required T failedValue,
  }) = InvalidCvv<T>;
}
