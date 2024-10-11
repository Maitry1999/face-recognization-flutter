part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required bool isPunchIn,
    required EmployeeAttandanceHelper employeeAttendance,
    required List<EmployeeAttendance> todaysEmployeePunch,
    required List<Map<String, List<EmployeeAttendance>>> employeePunchHistory,
    required LocalAuthentication auth,
    required SupportState supportState,
    required List<BiometricType> availableBiometrics,
    required String authorized,
    required String currentTime,

    required bool isAuthenticating,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _HomeState;
  factory HomeState.initial() => HomeState(
        isPunchIn: false,
        employeeAttendance: EmployeeAttandanceHelper(),
        todaysEmployeePunch: [],
        employeePunchHistory: [],
        auth: LocalAuthentication(),
        supportState: SupportState.unknown,
        availableBiometrics: [],
        authorized: 'Not Authorized',
        isAuthenticating: false,
        authFailureOrSuccessOption: none(), currentTime: '',
      );
}
