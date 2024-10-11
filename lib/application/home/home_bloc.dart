import 'dart:async';

import 'package:attandence_system/application/add_new_member/add_new_member_bloc.dart';
import 'package:attandence_system/domain/auth/account_failure.dart';
import 'package:attandence_system/infrastructure/employee_attandance/employee_attendance.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/core/helper/employee_attandance_helper.dart';
import 'package:attandence_system/presentation/core/helper/local_auth_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Timer timer;

  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>(
      (event, emit) async {
        await event.map(
          initEvent: (value) async {},
          punchInOut: (PunchInOut e) async {
            String punchType = state.isPunchIn ? 'out' : 'in';
            await LocalAuthHelper.isDeviceSupported(state.auth).then(
              (value) async {
                if (value) {
                  await LocalAuthHelper.checkBiometrics(state.auth).then(
                    (value) async {
                      if (value) {
                        try {
                          emit(state.copyWith(
                            isAuthenticating: true,
                            authorized: 'Authenticating',
                          ));
                          var res =
                              await LocalAuthHelper.authenticateWithBiometrics(
                                  state.auth);

                          emit(state.copyWith(
                            isAuthenticating: false,
                            authorized: 'Authenticating',
                          ));

                          if (res) {
                            // await state.employeeAttendance
                            //     .recordPunch(
                            //         getCurrentUser().userId ?? "", punchType)
                            //     .then(
                            //       (value) => showSuccess(
                            //               message: state.isPunchIn
                            //                   ? 'Checkout successfully.'
                            //                   : 'Checkin successfully.')
                            //           .show(e.context),
                            //     );
                            // add(const HomeEvent.loadTodaysEmployeePunch());
                            // add(const HomeEvent.loadEmployeePunchHistory());

                            // emit(state.copyWith(isPunchIn: !state.isPunchIn));
                          }
                        } on PlatformException catch (e) {
                          emit(state.copyWith(
                            isAuthenticating: false,
                            authorized: 'Error - ${e.message}',
                          ));
                        }
                      } else {
                        await showError(
                                message:
                                    'Your device is not able to check any biometrics')
                            .show(e.context);
                      }
                    },
                  );
                } else {
                  await showError(
                          message:
                              'Your device does not support any biometrics')
                      .show(e.context);
                }
              },
            );
          },
          loadTodaysEmployeePunch: (LoadTodaysEmployeePunch value) async {
            // List<EmployeeAttendance> todaysEmployeePunch = state
            //     .employeeAttendance
            //     .fetchPunches(getCurrentUser().userId ?? "");
            // emit(state.copyWith(todaysEmployeePunch: todaysEmployeePunch));
          },
          loadEmployeePunchHistory: (LoadEmployeePunchHistory value) async {
            // List<Map<String, List<EmployeeAttendance>>> history = state
            //     .employeeAttendance
            //     .fetchHistory(getCurrentUser().userId ?? "");
            // emit(state.copyWith(employeePunchHistory: history));
          },
          getCurrentTime: (GetCurrentTime value) async {
            timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              if (!isClosed) {
                add(HomeEvent.updateCurrentTime());
              } else {
                timer.cancel();
              }
            });
            emit(
              state.copyWith(
                currentTime: formatDateTime(
                  DateTime.now(),
                ),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          updateCurrentTime: (UpdateCurrentTime value) async {
            emit(
              state.copyWith(
                currentTime: formatDateTime(DateTime.now()),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
        );
      },
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy hh:mm:ss').format(dateTime);
  }

  // @override
  // Future<void> close() {
  //   timer.cancel(); // Cancel the timer when the Bloc is closed
  //   return super.close();
  // }
}
