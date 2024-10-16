import 'package:attandence_system/infrastructure/core/network/hive_box_names.dart';
import 'package:attandence_system/infrastructure/employee_attandance/employee_attendance.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class EmployeeAttandanceHelper {
  final Box punchBox = Hive.box(BoxNames.punchBox); // Box for today's punches
  final Box lastPunchDateBox =
      Hive.box(BoxNames.lastPunchDateBox); // Box for last punch date
  final Box historyBox =
      Hive.box(BoxNames.historyBox); // Box for storing historical punches

  Future<void> recordPunch(String userId, String type) async {
    // Get today's date (without time)
    String today = DateTime.now().toString().substring(0, 10);

    // Check if this is the first punch of the day
    String? lastPunchDate = lastPunchDateBox.get(userId);

    // If it's a new day, store the old punches in history and clear today's punches
    if (lastPunchDate != today) {
      await saveToHistory(
          userId, lastPunchDate); // Save the old day's punches in history
      await clearPunchesForToday(userId); // Clear today's punches
      await lastPunchDateBox.put(
          userId, today); // Save today's date as last punch date
    }

    // Now add the new punch
    String timeKey = DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.now());
    EmployeeAttendance punch = EmployeeAttendance(time: timeKey, type: type);
    await punchBox.put('${userId}_$timeKey', punch);
  }

  Future<void> saveToHistory(String userId, String? date) async {
    if (date == null) return;

    // Fetch the punches from today
    List<EmployeeAttendance> punches = fetchPunches(userId);
    if (punches.isNotEmpty) {
      // Store today's punches in the historyBox under the date
      await historyBox.put('${userId}_$date', punches);
    }
  }

  List<EmployeeAttendance> fetchPunches(String userId) {
    final keys = punchBox.keys.where((key) => key.startsWith(userId)).toList();
    return keys.map((key) => punchBox.get(key) as EmployeeAttendance).toList();
  }

  List<Map<String, List<EmployeeAttendance>>> fetchHistory(String userId) {
    // Fetch all history entries for the user
    final keys =
        historyBox.keys.where((key) => key.startsWith(userId)).toList();

    return keys.map((key) {
      String date = key.split('_')[1]; // Get the date from the key
      List<EmployeeAttendance> punches =
          historyBox.get(key).cast<EmployeeAttendance>();
      return {date: punches};
    }).toList();
  }

  Future<void> clearPunchesForToday(String userId) async {
    final keys = punchBox.keys.where((key) => key.startsWith(userId)).toList();
    for (var key in keys) {
      await punchBox.delete(key);
    }
  }
}
