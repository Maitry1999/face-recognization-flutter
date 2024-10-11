part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.getCurrentTime() = GetCurrentTime;
  const factory DashboardEvent.updateCurrentTime() = UpdateCurrentTime;
}
