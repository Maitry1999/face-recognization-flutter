import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/infrastructure/punch_in_out/punch_in_out_entity.dart';
import 'package:hive/hive.dart';
part 'account_entity.g.dart';

@HiveType(typeId: 0)
class AccountEntity extends HiveObject {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? countryCode;
  @HiveField(5)
  final int? phone;
  @HiveField(6)
  final String? designation;

  @HiveField(7)
  final List<PunchInOutRecord>? punchInOutTime;

  @HiveField(8)
  final List<double>? predictedData; // New field for storing face data
  @HiveField(9)
  final bool? isAdmin; // New field for storing face data
  AccountEntity(
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phone,
    this.designation,
    this.punchInOutTime,
    this.predictedData,
    this.isAdmin,
  );

  Account toDomain() {
    return Account(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      countryCode: countryCode,
      phone: phone,
      designation: designation,
      punchInOutTime: punchInOutTime,
      predictedData: predictedData,
      isAdmin: isAdmin,
    );
  }

  factory AccountEntity.fromDomain(Account account) {
    return AccountEntity(
      account.userId,
      account.firstName,
      account.lastName,
      account.email,
      account.countryCode,
      account.phone,
      account.designation,
      account.punchInOutTime,
      account.predictedData,
      account.isAdmin,
    );
  }
}
