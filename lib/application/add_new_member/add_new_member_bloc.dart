import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/domain/auth/account_failure.dart';
import 'package:attandence_system/domain/auth/auth_value_objects.dart';
import 'package:attandence_system/domain/auth/i_auth_facade.dart';
import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/core/network/hive_box_names.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

part 'add_new_member_state.dart';
part 'add_new_member_event.dart';
part 'add_new_member_bloc.freezed.dart';

@injectable
class AddNewMemberBloc extends Bloc<AddNewMemberEvent, AddNewMemberState> {
  final IAuthFacade _authFacade;
  AddNewMemberBloc(this._authFacade) : super(AddNewMemberState.initial()) {
    on<AddNewMemberEvent>(
      (event, emit) async {
        await event.map(
          addNewMember: (e) async {
            Either<AuthFailure, Unit>? failureOrSuccess;

            final isEmailValid = state.emailAddress.isValid();
            final isFirstNameValid = state.firstName.isValid();
            final isLastNameValid = state.lastName.isValid();
            final isMobileNumberValid = state.mobileNumber.isValid();
            final isEnrollmentIdValid = state.enrollmentID.isValid();

            if (isFirstNameValid &&
                isLastNameValid &&
                isMobileNumberValid &&
                isEmailValid &&
                isEnrollmentIdValid) {
              // Check if the enrollment ID already exists in local storage
              final box =
                  await Hive.openBox<AccountEntity>(BoxNames.currentUser);
              final existingAccount = box.values.toList().firstWhereOrNull(
                    (account) =>
                        account.enrollmentID == state.enrollmentID.getOrCrash(),
                  );

              if (existingAccount != null) {
                // Show error toast if enrollment ID already exists
                ScaffoldMessenger.of(e.context).showSnackBar(
                  SnackBar(content: Text('Enrollment ID already exists')),
                );
                return; // Exit the function early
              }

              emit(
                state.copyWith(
                  isSubmitting: true,
                  authFailureOrSuccessOption: none(),
                ),
              );

              var res = await e.context.router.push<List<double>>(
                PageRouteInfo(
                  FaceDetectorView.name,
                  args: FaceDetectorViewArgs(isUserRegistring: true),
                ),
              );

              if (res != null) {
                failureOrSuccess = await _authFacade.registerUserData(
                  Account(
                    enrollmentID: state.enrollmentID.getOrCrash(),
                    countryCode: state.selectedCountrycode,
                    designation: state.designation.getOrCrash(),
                    email: state.emailAddress.getOrCrash(),
                    firstName: state.firstName.getOrCrash(),
                    lastName: state.lastName.getOrCrash(),
                    isPunchIn: false,
                    phone: int.tryParse(state.mobileNumber.getOrCrash()),
                    predictedData: res,
                    isAdmin: state.isAdmin,
                    isPunchInFromEverywhere:
                        state.manualLocation.contains('Everywhere'),
                  ),
                );
              }
            }

            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                authFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          },
          emailChanged: (value) async {
            emit(
              state.copyWith(
                emailAddress: EmailAddress(value.email),
              ),
            );
          },
          getPrefilledPhoneNumber: (value) async {},
          lastNameChanged: (value) async {
            emit(
              state.copyWith(
                lastName: Username(value.lastName),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          firstNameChanged: (value) async {
            emit(
              state.copyWith(
                firstName: Username(value.firstName),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          mobileNumberChanged: (value) async {
            emit(
              state.copyWith(
                mobileNumber: MobileNumber(
                  value.mobileNumber,
                ),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          selectCountryCode: (value) async {
            emit(
              state.copyWith(
                selectedCountrycode: value.counryCode,
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          designationChanged: (value) async {
            emit(
              state.copyWith(
                designation: InputEmptyOrNot(value.designation),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          isNewMemberAdmin: (IsNewMemberAdmin value) async {
            emit(
              state.copyWith(
                isAdmin: value.isAdmin,
                embeddings: value.embeddings,
              ),
            );
          },
          enrollmentIdChanged: (EnrollmentIdChanged value) async {
            emit(
              state.copyWith(
                enrollmentID: InputEmptyOrNot(value.enrollmentId),
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          locationSelectionChanged: (_LocationSelectionChanged value) async {
            emit(
              state.copyWith(
                isDefaultLocation: value.isDefault,
                authFailureOrSuccessOption: none(),
              ),
            );
          },
          manualLocationChanged: (_ManualLocationChanged value) async {
            emit(
              state.copyWith(
                manualLocation: value.location,
                authFailureOrSuccessOption: none(),
              ),
            );
          },
        );
      },
    );
  }
}
