part of 'add_new_member_bloc.dart';

@freezed
class AddNewMemberEvent with _$AddNewMemberEvent {
  const factory AddNewMemberEvent.addNewMember(
      BuildContext context, List<double> embeddings) = AddNewMember;
  const factory AddNewMemberEvent.emailChanged(String email) = EmailChanged;

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
  const factory AddNewMemberEvent.start() = Start;
  const factory AddNewMemberEvent.frameFaces() = FrameFaces;
  const factory AddNewMemberEvent.isNewMemberAdmin(
      bool isAdmin, List<double> embeddings) = IsNewMemberAdmin;
}
