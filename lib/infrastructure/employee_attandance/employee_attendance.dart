import 'package:hive/hive.dart';

part 'employee_attendance.g.dart';

@HiveType(typeId: 1)
class EmployeeAttendance {
  @HiveField(0)
  final String time;

  @HiveField(1)
  final String type;

  EmployeeAttendance({required this.time, required this.type});
}
