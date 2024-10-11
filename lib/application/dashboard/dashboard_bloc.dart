import 'dart:async';

import 'package:attandence_system/domain/auth/account_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'dashboard_state.dart';
part 'dashboard_event.dart';
part 'dashboard_bloc.freezed.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  late Timer timer;
  DashboardBloc() : super(DashboardState.initial()) {
    on<DashboardEvent>((event, emit) async {
      await event.map(
        getCurrentTime: (value) async {
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (!isClosed) {
              add(DashboardEvent.updateCurrentTime());
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
        updateCurrentTime: (e) async {
          emit(
            state.copyWith(
              currentTime: formatDateTime(DateTime.now()),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
      );
    });
  }
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy hh:mm:ss').format(dateTime);
  }
}
