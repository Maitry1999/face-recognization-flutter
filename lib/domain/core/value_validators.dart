import 'dart:io';

import 'package:attandence_system/domain/core/failures.dart';
import 'package:dartz/dartz.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  if (validateStringNotEmpty(input).isRight()) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

    if (RegExp(emailRegex).hasMatch(input)) {
      return right(input);
    } else {
      return left(ValueFailure.invalidEmail(failedValue: input));
    }
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateUsername(String input) {
  if (validateStringNotEmpty(input).isRight()) {
    if (input.length >= 2 && input.length <= 32) {
      return right(input);
    } else {
      return left(ValueFailure.invalidUsername(failedValue: input));
    }
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateMobileNumber(String input) {
  // log(input);
  if (validateStringNotEmpty(input).isRight()) {
    if (input.trim().length >= 8 && input.trim().length <= 15) {
      return right(input);
    } else {
      return left(ValueFailure.invalidMobileNumber(failedValue: input));
    }
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateCardNumber(String input) {
  if (validateStringNotEmpty(input).isRight()) {
    if (input.length > 12) {
      return right(input);
    } else {
      return left(ValueFailure.invalidCardNumber(failedValue: input));
    }
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateCvv(String input) {
  if (input.length < 3 || input.length > 4) {
    return left(ValueFailure.invalidCvv(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateCardDate(String input) {
  if (validateStringNotEmpty(input).isRight()) {
    int year;
    int month;
    if (input.contains(RegExp(r'(/)'))) {
      var split = input.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(input.substring(0, (input.length)));
      year = -1;
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    if ((month < 1) || (month > 12)) {
      return left(ValueFailure.invalidaCardMonth(failedValue: input));
    } else if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      return left(ValueFailure.invalidaCardYear(failedValue: input));
    } else if (!hasDateExpired(month, year)) {
      return left(ValueFailure.cardExpired(failedValue: input));
    } else {
      return right(input);
    }
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.trim().isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<List<T>>, List<T>> validateMaxGuildLength<T>(
  List<T> input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.tooManyGuilds(
        failedValue: input,
        max: maxLength,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (validateStringNotEmpty(input).isRight()) {
    if (input.length < maxLength) {
      return left(
        ValueFailure.exceedingLength(failedValue: input, max: maxLength),
      );
    } else {
      return right(input);
    }
  } else {
    return left(
      ValueFailure.empty(failedValue: input),
    );
  }
}

Either<ValueFailure<String>, String> validatePincode(String input) {
  if (validateStringNotEmpty(input).isRight()) {
    if ((input.trim().length == 6 || input.trim().length == 5)) {
      return right(input);
    } else {
      return left(ValueFailure.exceedingLength(failedValue: input, max: 6));
    }
  } else {
    return left(
      ValueFailure.empty(failedValue: input),
    );
  }
}

Either<ValueFailure<File>, File> validateMaxFileSize(
  File input,
  int maxSize,
) {
  if (input.lengthSync() <= maxSize) {
    return right(input);
  } else {
    return left(
      ValueFailure.exceedingSize(failedValue: input, max: maxSize),
    );
  }
}

Either<ValueFailure<String>, String> validateHexColor(
  String input,
) {
  const hexRegex = r"""^#[0-9a-f]{3}(?:[0-9a-f]{3})?$""";
  if (RegExp(hexRegex, caseSensitive: false).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidColor(failedValue: input));
  }
}

/// Check if ID is the right length and numeric
Either<ValueFailure<String>, String> validateUID(String input) {
  if (input.length >= 18 &&
      input.length <= 22 &&
      double.tryParse(input) != null) {
    return right(input);
  } else {
    return left(ValueFailure.invalidUID(failedValue: input));
  }
}

bool hasDateExpired(int month, int year) {
  return isNotExpired(year, month);
}

bool isNotExpired(int year, int month) {
  return !hasYearPassed(year) && !hasMonthPassed(year, month);
}

bool hasYearPassed(int year) {
  int fourDigitsYear = convertYearTo4Digits(year);
  var now = DateTime.now();

  return fourDigitsYear < now.year;
}

int convertYearTo4Digits(int year) {
  if (year < 100 && year >= 0) {
    var now = DateTime.now();
    String currentYear = now.year.toString();
    String prefix = currentYear.substring(0, currentYear.length - 2);
    year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
  }
  return year;
}

bool hasMonthPassed(int year, int month) {
  var now = DateTime.now();
  return hasYearPassed(year) ||
      convertYearTo4Digits(year) == now.year && (month < now.month + 1);
}
