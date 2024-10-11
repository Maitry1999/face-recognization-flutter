import 'dart:io';

import 'package:attandence_system/application/dashboard/dashboard_bloc.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/utils/get_current_user.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:attandence_system/presentation/common/widgets/custom_appbar.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:attandence_system/presentation/core/buttons/common_button.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'DashboardView')
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DashboardBloc>()..add(DashboardEvent.getCurrentTime()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Attendance System',
              actions: [
                IconButton(
                  onPressed: () {
                    generateUserPunchInOutReport();
                  },
                  icon: Icon(
                    Icons.download,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showRegisterBottomSheet(context);
                  },
                  icon: Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(height: getSize(20)),
                Center(
                  child: BaseText(
                    text: state.currentTime,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: getSize(20)),
                CommonButton(
                    onPressed: () {
                      context.router.push(PageRouteInfo(FaceDetectorView.name,
                          args: FaceDetectorViewArgs(isUserRegistring: false)));
                    },
                    buttonText: 'Detect')
                // Expanded(
                //     child: widget.FaceDetectorView(
                //   isUserRegistring: false,
                // )),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> generateUserPunchInOutReport() async {
    // Fetch user data
    List<AccountEntity> users = getCurrentUser()
        .map(
          (e) => AccountEntity.fromDomain(e),
        )
        .toList();

    // Create a PDF document
    final pdf = pw.Document();

    // Loop through each user and their punch-in/out times
    for (var user in users) {
      if (user.punchInOutTime != null && user.punchInOutTime!.isNotEmpty) {
        // Group by date
        Map<DateTime, List<DateTime>> punchTimesByDate = {};
        for (var punchTime in user.punchInOutTime!) {
          DateTime dateOnly =
              DateTime(punchTime.year, punchTime.month, punchTime.day);
          punchTimesByDate.putIfAbsent(dateOnly, () => []).add(punchTime);
        }

        // Add a page for each user
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  pw.Text(
                      'Punch In/Out Times for ${user.firstName} ${user.lastName}',
                      style: pw.TextStyle(fontSize: 24)),
                  pw.SizedBox(height: 20),
                  pw.Table.fromTextArray(
                    context: context,
                    data: <List<String>>[
                      <String>['Date', 'Punch Times'],
                      ...punchTimesByDate.entries.map((entry) {
                        String date =
                            '${entry.key.day}/${entry.key.month}/${entry.key.year}';
                        String punchTimes = entry.value
                            .map((time) => '${time.hour}:${time.minute}')
                            .join(', ');
                        return [date, punchTimes];
                      }),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      }
    }

    // Save the PDF file to internal storage
    try {
      final directory =
          await getApplicationDocumentsDirectory(); // Get internal storage directory
      final file = File(
          "${directory.path}/punch_in_out_report.pdf"); // Specify the file name
      await file.writeAsBytes(await pdf.save());
      print("PDF saved to: ${file.path}");

      // Optionally, you can open the file or show a success message
      // You can use a package like open_file or url_launcher to open the PDF
    } catch (e) {
      print("Error saving PDF: $e");
    }
  }

  void _showRegisterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: getSize(30)),
              BaseText(
                text: 'Register As',
                textAlign: TextAlign.center,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getSize(20)),
              CommonButton(
                onPressed: () {
                  // Handle Register as Member
                  context.router.maybePop();
                  _registerAsMember(context);
                },
                buttonText: 'Register as Member',
              ),
              SizedBox(height: getSize(20)),
              CommonButton(
                backgroundColor: AppColors.white,
                borderColor: AppColors.green,
                buttonTextColor: AppColors.black,
                onPressed: () {
                  // Handle Register as Admin
                  context.router.maybePop();
                  _registerAsAdmin(context);
                },
                buttonText: 'Register as Admin',
              ),
              SizedBox(height: getSize(30)),
            ],
          ),
        );
      },
    );
  }

  void _registerAsMember(BuildContext context) {
    print('Registered as Member');
    context.router.push(
      PageRouteInfo(
        AddMemberView.name,
        args: AddMemberViewArgs(isAdmin: false),
      ),
    );
  }

  void _registerAsAdmin(BuildContext context) {
    // Navigate to Admin Registration Screen or handle the admin registration logic here
    print('Registered as Admin');
    context.router.push(
      PageRouteInfo(
        AddMemberView.name,
        args: AddMemberViewArgs(isAdmin: true),
      ),
    );
  }
}
