import 'dart:io';

import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/punch_in_out/punch_in_out_entity.dart';
import 'package:attandence_system/presentation/common/utils/get_current_user.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

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

    // Create a date format for the time in HH:mm:ss format
    final timeFormat = DateFormat('HH:mm:ss');

    // Add a page to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Biometric In-Out Reports',
                  style: pw.TextStyle(fontSize: 24)),
              pw.Text(
                  'Date: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                  style: pw.TextStyle(fontSize: 12)),
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

                  // Find the maximum number of in-out times in the records to dynamically create columns
                  int maxPunchCount =
                      groupedRecords.entries.fold(0, (maxCount, entry) {
                    return entry.value.length > maxCount
                        ? entry.value.length
                        : maxCount;
                  });

                  // Dynamically generate the headers for in-out columns
                  List<String> dynamicHeaders = ['Date'];
                  for (int i = 0; i < maxPunchCount; i++) {
                    dynamicHeaders.add('In Time ${i + 1}');
                    dynamicHeaders.add('Out Time ${i + 1}');
                  }
                  dynamicHeaders.add('Total Hours');
                  dynamicHeaders.add('Break Hours');
                  dynamicHeaders.add('Status');

                  // Generate user report with dynamic in-out columns
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Name: ${user.firstName} ${user.lastName}',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Table.fromTextArray(
                        context: context,
                        headers: dynamicHeaders,
                        data: groupedRecords.entries.map((entry) {
                          String date = entry.key;
                          List<PunchInOutRecord> records = entry.value;

                          // Collect in/out times for each record
                          List<String> punchData = [];
                          for (var record in records) {
                            String inTime = timeFormat.format(record.punchIn);
                            String outTime = record.punchOut != null
                                ? timeFormat.format(record.punchOut!)
                                : 'N/A';
                            punchData.add(inTime);
                            punchData.add(outTime);
                          }

                          // Add empty fields if the number of punch records is less than the maximum
                          while (punchData.length < maxPunchCount * 2) {
                            punchData.add('');
                            punchData.add('');
                          }

                          // Calculate total hours worked for the day
                          Duration totalDuration = records.fold(
                            Duration.zero,
                            (previousValue, record) {
                              if (record.punchOut != null) {
                                return previousValue +
                                    record.punchOut!.difference(record.punchIn);
                              }
                              return previousValue;
                            },
                          );
                          String totalHours = '${totalDuration.inHours}:${(totalDuration.inMinutes % 60)
                                  .toString()
                                  .padLeft(2, '0')}';

                          // Calculate break hours (time between consecutive out-in pairs)
                          Duration breakDuration = Duration.zero;
                          for (int i = 0; i < records.length - 1; i++) {
                            if (records[i].punchOut != null) {
                              breakDuration += records[i + 1]
                                  .punchIn
                                  .difference(records[i].punchOut!);
                            }
                          }
                          String breakHours = '${breakDuration.inHours}:${(breakDuration.inMinutes % 60)
                                  .toString()
                                  .padLeft(2, '0')}';

                          // Determine status based on punch-in and punch-out times
                          String status;
                          if (records.isEmpty) {
                            status = 'Absent';
                          } else if (records.any((r) => r.punchOut == null)) {
                            status = 'Miss Punch';
                          } else {
                            status = 'Present';
                          }

                          // Add total hours, break hours, and status at the end of the row
                          punchData.add(totalHours);
                          punchData.add(breakHours);
                          punchData.add(status);

                          return [date, ...punchData];
                        }).toList(),
                      ),
                      pw.SizedBox(height: 20),
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
      final filePath = "$path/biomatric_report_$sanitizedFileName.pdf";
      final file = File(filePath);

      try {
        await file.writeAsBytes(await pdf.save());
        // print("PDF saved to: $filePath");

        // Open the PDF file after saving
        await OpenFile.open(filePath); // This will open the saved PDF file

        // await context.router.push(
        //   PageRouteInfo(
        //     SuccessScreen.name,
        //     args: SuccessScreenArgs(message: 'Pdf downloaded successfully.'),
        //   ),
        // );
      } catch (e) {
        print("Error saving PDF: $e");
      }
    } else {
      print("Permission denied.");
    }
  }
}
