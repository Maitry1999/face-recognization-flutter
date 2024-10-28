part of 'add_new_member_bloc.dart';

@freezed
class AddNewMemberEvent with _$AddNewMemberEvent {
  const factory AddNewMemberEvent.addNewMember(BuildContext context) =
      AddNewMember;
  const factory AddNewMemberEvent.emailChanged(String email) = EmailChanged;

  const factory AddNewMemberEvent.enrollmentIdChanged(String enrollmentId) =
      EnrollmentIdChanged;

  const factory AddNewMemberEvent.getPrefilledPhoneNumber(
      String countryCode, String phoneNumber) = GetPrefilledPhoneNumber;

  const factory AddNewMemberEvent.lastNameChanged(String lastName) =
      LastNameChanged;
  const factory AddNewMemberEvent.firstNameChanged(String firstName) =
      FirstNameChanged;
  const factory AddNewMemberEvent.mobileNumberChanged(String mobileNumber) =
      MobileNumberChanged;

  const factory AddNewMemberEvent.designationChanged(String designation) =
      DesignationChanged;
  const factory AddNewMemberEvent.selectCountryCode(String counryCode) =
      SelectCountryCode;
  // New event for toggling between default and manual location
  const factory AddNewMemberEvent.locationSelectionChanged(bool isDefault) =
      _LocationSelectionChanged;

  // New event for updating the manual location field
  const factory AddNewMemberEvent.manualLocationChanged(String location) =
      _ManualLocationChanged;
  const factory AddNewMemberEvent.isNewMemberAdmin(
      bool isAdmin, List<double> embeddings) = IsNewMemberAdmin;
}
