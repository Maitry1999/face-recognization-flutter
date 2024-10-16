import 'package:hive/hive.dart';
part 'punch_in_out_entity.g.dart';

@HiveType(typeId: 1)
class PunchInOutRecord {
  @HiveField(0)
  final DateTime punchIn;

  @HiveField(1)
  final DateTime? punchOut;

  PunchInOutRecord(this.punchIn, this.punchOut);
}
