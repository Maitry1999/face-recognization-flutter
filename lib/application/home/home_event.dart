part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initEvent() = InitEvent;
  const factory HomeEvent.punchInOut(BuildContext context) = PunchInOut;
  const factory HomeEvent.loadTodaysEmployeePunch() = LoadTodaysEmployeePunch;
  const factory HomeEvent.loadEmployeePunchHistory() = LoadEmployeePunchHistory;
  const factory HomeEvent.getCurrentTime() = GetCurrentTime;
  const factory HomeEvent.updateCurrentTime() = UpdateCurrentTime;
}
