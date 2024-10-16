import 'package:freezed_annotation/freezed_annotation.dart';
part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? countryCode,
    String? designation,
    int? phone,
    List<DateTime>? punchInOutTime,
    bool? isAdmin,
    List<double>? predictedData,
  }) = _Account;
}
