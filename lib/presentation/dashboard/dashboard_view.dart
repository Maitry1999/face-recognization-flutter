import 'package:attandence_system/application/dashboard/dashboard_bloc.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:attandence_system/presentation/common/widgets/custom_appbar.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
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
              actions: [],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              child: Column(
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
                      context.router.push(
                        PageRouteInfo(
                          FaceDetectorView.name,
                        ),
                      );
                    },
                    buttonText: 'In/Out',
                  ),
                  SizedBox(height: getSize(20)),
                  CommonButton(
                    onPressed: () {
                      context.router.push(
                        PageRouteInfo(FaceDetectorView.name,
                            args: FaceDetectorViewArgs(forDownloadData: true)),
                      );
                    },
                    buttonText: 'Download Report',
                  ),
                  SizedBox(height: getSize(20)),
                  CommonButton(
                    onPressed: () {
                      _showRegisterBottomSheet(context);
                    },
                    buttonText: 'Add Member',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String?> _showRegisterBottomSheet(BuildContext context) async {
    return await showModalBottomSheet<String>(
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
                onPressed: () async {
                  // Handle Register as Member
                  context.router.maybePop(await _registerAsMember(context));
                },
                buttonText: 'Register as Member',
              ),
              SizedBox(height: getSize(20)),
              CommonButton(
                backgroundColor: AppColors.white,
                borderColor: AppColors.green,
                buttonTextColor: AppColors.black,
                onPressed: () async {
                  // Handle Register as Admin
                  context.router.maybePop(await _registerAsAdmin(context));
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

  _registerAsMember(BuildContext context) async {
    print('Registered as Member');
    await context.router.maybePop();
    await context.router.push(
      PageRouteInfo(
        AddMemberView.name,
        args: AddMemberViewArgs(isAdmin: false),
      ),
    );
  }

  _registerAsAdmin(BuildContext context) async {
    // Navigate to Admin Registration Screen or handle the admin registration logic here
    print('Registered as Admin');
    await context.router.maybePop();

    await context.router.push(
      PageRouteInfo(
        AddMemberView.name,
        args: AddMemberViewArgs(
          isAdmin: true,
        ),
      ),
    );
  }
}
