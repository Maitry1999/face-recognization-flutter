part of 'add_new_member_bloc.dart';

enum SupportState {
  unknown,
  supported,
  unsupported,
}

@freezed
class AddNewMemberState with _$AddNewMemberState {
  const factory AddNewMemberState({
    required EmailAddress emailAddress,
    required Username firstName,
    required Username lastName,
    required String profileImagePath,
    required InputEmptyOrNot designation,
    required MobileNumber mobileNumber,
    required bool showErrorMessages,
    required bool isSubmitting,
    required String selectedCountrycode,
    required LocalAuthentication auth,
    required SupportState supportState,
    required List<BiometricType> availableBiometrics,
    required String authorized,
    required bool isAdmin,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
    required String imagePath,
//    Face? faceDetected,
    Size? imageSize,
    required bool detectingFaces,
    required bool pictureTaken,
    required bool initializing,
    required bool saving,
    // required FaceDetectorService faceDetectorService,
    // required CameraService cameraService,
    // required MLService mlService,
  }) = _AddNewMemberState;

  factory AddNewMemberState.initial() => AddNewMemberState(
        mobileNumber: MobileNumber(''),
        showErrorMessages: false,
        isSubmitting: false,
        selectedCountrycode: '91',
        emailAddress: EmailAddress(''),
        firstName: Username(''),
        lastName: Username(''),
        profileImagePath: '',
        designation: InputEmptyOrNot(''),
        auth: LocalAuthentication(),
        supportState: SupportState.unknown,
        availableBiometrics: [],
        authorized: 'Not Authorized',
        isAdmin: false,
        authFailureOrSuccessOption: none(),
        imagePath: '',
        // mlService: getIt<MLService>(),
        // cameraService: getIt<CameraService>(),
        // faceDetectorService: getIt<FaceDetectorService>(),
        imageSize: null,
        detectingFaces: false,
        pictureTaken: false,
        initializing: false,
        saving: false,
      );
}
