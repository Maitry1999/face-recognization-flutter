import 'package:attandence_system/domain/core/failures.dart';
import 'package:attandence_system/domain/core/value_objects.dart';
import 'package:attandence_system/domain/core/value_validators.dart';
import 'package:dartz/dartz.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}

class PinCode extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PinCode(String input) {
    return PinCode._(
      validatePincode(input),
    );
  }

  const PinCode._(this.value);
}

class OTPText extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory OTPText(String input) {
    return OTPText._(
      validateMaxStringLength(input, 4),
    );
  }

  const OTPText._(this.value);
}

class Username extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Username(String input) {
    return Username._(
      validateUsername(input),
    );
  }

  const Username._(this.value);
}

class MobileNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory MobileNumber(String input) {
    return MobileNumber._(
      validateMobileNumber(input),
    );
  }

  const MobileNumber._(this.value);
}

class InputEmptyOrNot extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory InputEmptyOrNot(String input) {
    return InputEmptyOrNot._(
      validateStringNotEmpty(input),
    );
  }

  const InputEmptyOrNot._(this.value);
}

class CardNumber extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory CardNumber(String input) {
    return CardNumber._(
      validateCardNumber(input),
    );
  }

  const CardNumber._(this.value);
}

class CardDate extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory CardDate(String value) {
    return CardDate._(
      validateCardDate(value),
    );
  }

  const CardDate._(this.value);
}

class CVV extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory CVV(String value) {
    return CVV._(
      validateCvv(value),
    );
  }
  const CVV._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }
  const Password._(this.value);
}
