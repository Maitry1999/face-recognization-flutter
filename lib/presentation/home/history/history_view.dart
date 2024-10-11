import 'package:attandence_system/application/home/home_bloc.dart';
import 'package:attandence_system/infrastructure/employee_attandance/employee_attendance.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:attandence_system/presentation/common/widgets/custom_appbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'HistoryView')
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()
        ..add(HomeEvent.loadTodaysEmployeePunch())
        ..add(HomeEvent.loadEmployeePunchHistory()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => Scaffold(
          appBar: CustomAppBar(title: 'Your History'),
          body: state.employeePunchHistory.isEmpty
              ? Center(
                  child: BaseText(text: 'No previous history found.'),
                )
              : ListView.builder(
                  itemCount: state.employeePunchHistory.length,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String date = state.employeePunchHistory[index].keys.first;
                    List<EmployeeAttendance> punches =
                        state.employeePunchHistory[index].values.first;

                    return Column(
                      children: [
                        BaseText(text: date),
                        Expanded(
                          child: ListView.builder(
                            itemCount: punches.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                minVerticalPadding: 0,
                                visualDensity: VisualDensity.compact,
                                contentPadding: EdgeInsets.zero,
                                title: Text("Time: ${punches[index].time}"),
                                subtitle: Text("Punch: ${punches[index].type}"),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
