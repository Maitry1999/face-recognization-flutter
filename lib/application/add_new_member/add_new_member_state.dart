part of 'add_new_member_bloc.dart';

@freezed
class AddNewMemberState with _$AddNewMemberState {
  const factory AddNewMemberState({
    required EmailAddress emailAddress,
    required Username firstName,
    required Username lastName,
    required InputEmptyOrNot designation,
    required MobileNumber mobileNumber,
    required bool showErrorMessages,
    required bool isSubmitting,
    required String selectedCountrycode,
    required bool isAdmin,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
    required List<double> embeddings,
    Size? imageSize,
    required bool detectingFaces,
    required bool pictureTaken,
    required bool initializing,
    required bool saving,
  }) = _AddNewMemberState;

  factory AddNewMemberState.initial() => AddNewMemberState(
        mobileNumber: MobileNumber(''),
        showErrorMessages: false,
        isSubmitting: false,
        selectedCountrycode: '91',
        emailAddress: EmailAddress(''),
        firstName: Username(''),
        lastName: Username(''),
        designation: InputEmptyOrNot(''),
        isAdmin: false,
        authFailureOrSuccessOption: none(),
        imageSize: null,
        detectingFaces: false,
        pictureTaken: false,
        initializing: false,
        saving: false,
        embeddings: [],
      );
}
