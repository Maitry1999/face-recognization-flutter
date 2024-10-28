import 'package:attandence_system/infrastructure/punch_in_out/punch_in_out_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    String? enrollmentID,
    String? firstName,
    String? lastName,
    String? email,
    String? countryCode,
    String? designation,
    int? phone,
    List<PunchInOutRecord>? punchInOutTime,
    bool? isAdmin,
    bool? isPunchIn,
    bool? isPunchInFromEverywhere,
    List<double>? predictedData,
  }) = _Account;
}
