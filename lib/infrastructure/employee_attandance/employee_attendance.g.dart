// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_attendance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeAttendanceAdapter extends TypeAdapter<EmployeeAttendance> {
  @override
  final int typeId = 1;

  @override
  EmployeeAttendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeAttendance(
      time: fields[0] as String,
      type: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeAttendance obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeAttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
