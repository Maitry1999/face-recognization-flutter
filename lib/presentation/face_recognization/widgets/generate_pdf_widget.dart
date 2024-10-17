import 'dart:io';

import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/punch_in_out/punch_in_out_entity.dart';
import 'package:attandence_system/presentation/common/utils/get_current_user.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PdfGenerateView extends StatelessWidget {
  const PdfGenerateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> generateUserPunchInOutReport(BuildContext context) async {
    // Fetch user data
    List<AccountEntity> users =
        getCurrentUser().map((e) => AccountEntity.fromDomain(e)).toList();

    // Create a PDF document
    final pdf = pw.Document();

    // Create a date format for the time in AM/PM format
    final timeFormat = DateFormat('h:mm:ss a');

    // Add a page to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Punch In/Out Times Report',
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              // Iterate through each user and display their punch-in/out times
              ...users.map((user) {
                if (user.punchInOutTime != null &&
                    user.punchInOutTime!.isNotEmpty) {
                  // Group punch-in and punch-out records by date
                  Map<String, List<PunchInOutRecord>> groupedRecords = {};
                  for (var record in user.punchInOutTime!) {
                    String dateKey =
                        '${record.punchIn.day}/${record.punchIn.month}/${record.punchIn.year}';
                    if (!groupedRecords.containsKey(dateKey)) {
                      groupedRecords[dateKey] = [];
                    }
                    groupedRecords[dateKey]!.add(record);
                  }

                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Display user details
                      pw.Text(
                        'User ID: ${user.userId}',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Name: ${user.firstName} ${user.lastName}',
                        style: pw.TextStyle(fontSize: 16),
                      ),
                      pw.Text(
                        'Email: ${user.email}',
                        style: pw.TextStyle(fontSize: 16),
                      ),
                      pw.SizedBox(height: 10),

                      // Display punch-in and punch-out times in a table
                      ...groupedRecords.entries.map((entry) {
                        String date = entry.key;
                        List<PunchInOutRecord> records = entry.value;

                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(date,
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Table.fromTextArray(
                              context: context,
                              columnWidths: {
                                0: const pw
                                    .FlexColumnWidth(), // Dynamic width for punch-in
                                1: const pw
                                    .FlexColumnWidth(), // Dynamic width for punch-out
                              },
                              data: <List<String>>[
                                <String>['Punch In', 'Punch Out'],
                                ...records.map((record) {
                                  String punchInTime =
                                      timeFormat.format(record.punchIn);
                                  String punchOutTime = record.punchOut != null
                                      ? timeFormat.format(record.punchOut!)
                                      : 'No Punch Out'; // Show 'No Punch Out' if null
                                  return [punchInTime, punchOutTime];
                                }),
                              ],
                            ),
                            pw.SizedBox(height: 20), // Space between dates
                          ],
                        );
                      }),
                      pw.SizedBox(height: 20), // Space between users
                    ],
                  );
                } else {
                  return pw
                      .SizedBox(); // Empty if no punch times exist for the user
                }
              }),
            ],
          );
        },
      ),
    );

    // Request storage permissions
    PermissionStatus status;
    if (Platform.isAndroid &&
        await DeviceInfoPlugin()
            .androidInfo
            .then((value) => value.version.sdkInt >= 30)) {
      status = await Permission.manageExternalStorage.request();
    } else {
      status = await Permission.storage.request();
    }

    // Save the PDF if permission is granted
    if (status.isGranted) {
      var path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      final sanitizedFileName = DateTime.now().toString().replaceAll(':', '-');
      final filePath = "$path/punch_in_out_report_$sanitizedFileName.pdf";
      final file = File(filePath);

      try {
        await file.writeAsBytes(await pdf.save());
        print("PDF saved to: $filePath");

        await context.router.push(PageRouteInfo(SuccessScreen.name,
            args: SuccessScreenArgs(message: 'Pdf downloaded successfully.')));
      } catch (e) {
        print("Error saving PDF: $e");
      }
    } else {
      print("Permission denied.");
    }
  }
}
