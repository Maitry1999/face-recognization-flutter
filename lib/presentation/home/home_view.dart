import 'package:attandence_system/application/home/home_bloc.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:attandence_system/presentation/common/widgets/custom_appbar.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:attandence_system/presentation/core/buttons/common_button.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:attandence_system/presentation/home/widgets/user_profile_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'HomeView')
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()
        ..add(HomeEvent.getCurrentTime())
        ..add(HomeEvent.loadTodaysEmployeePunch()),
      child: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Your Daily Logs',
              actions: [
                IconButton(
                  onPressed: () {
                    context.router.push(
                      PageRouteInfo(HistoryView.name),
                    );
                  },
                  icon: Icon(
                    Icons.history_rounded,
                  ),
                ),
              ],
            ),
            body: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                BaseText(
                  text: state.currentTime,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                UserProfileView(),
                buildTodayPunches(state),
                //  buildPunchHistory(state),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(20),
                vertical: getSize(25),
              ),
              child: CommonButton(
                onPressed: () {
                  context.read<HomeBloc>().add(HomeEvent.punchInOut(context));
                },
                backgroundColor: state.isPunchIn ? AppColors.red : null,
                buttonText: state.isPunchIn ? 'Out' : 'In',
              ),
            ),
          );
        },
        listener: (BuildContext context, HomeState state) {},
      ),
    );
  }

  Widget buildTodayPunches(HomeState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BaseText(
          //   text: '${getCurrentUser().firstName}\'s Today\'s Logs',
          //   fontSize: 16,
          //   fontWeight: FontWeight.w600,
          // ),
          SizedBox(height: getSize(20)), // Add some space below the title

          // Check if today's employee punch list is empty
          if (state.todaysEmployeePunch.isEmpty)
            Center(
              child: BaseText(
                text: "No punches recorded for today.",
                fontSize: 12,
                textColor: AppColors.black.withOpacity(0.40),
                textAlign: TextAlign.center,
              ),
            )
          else
            ...state.todaysEmployeePunch.map((punch) {
              return ListTile(
                dense: true,
                minVerticalPadding: 0,
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                title: BaseText(text: "Time: ${punch.time}"),
                subtitle: BaseText(text: "Punch: ${punch.type}"),
              );
            }),
          SizedBox(height: getSize(20)),
        ],
      ),
    );
  }

  // Widget buildPunchHistory(HomeState state) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text("Punch History",
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //       ...state.employeePunchHistory.map((entry) {
  //         String date = entry.keys.first;
  //         List<EmployeeAttendance> punches = entry.values.first;

  //         return ExpansionTile(
  //           title: Text("Date: $date"),
  //           children: punches.map((punch) {
  //             return ListTile(
  //               title: Text("Time: ${punch.time}"),
  //               subtitle: Text("Punch: ${punch.type}"),
  //             );
  //           }).toList(),
  //         );
  //       }),
  //     ],
  //   );
  // }
}
