part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  factory DashboardState({
    required bool isPunchIn,
    required String currentTime,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _DashboardState;
  factory DashboardState.initial() => DashboardState(
        isPunchIn: false,
        authFailureOrSuccessOption: none(),
        currentTime: '',
      );
}
