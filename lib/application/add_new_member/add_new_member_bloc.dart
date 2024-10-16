import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/domain/auth/account_failure.dart';
import 'package:attandence_system/domain/auth/auth_value_objects.dart';
import 'package:attandence_system/domain/auth/i_auth_facade.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
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

            if (isFirstNameValid &&
                isLastNameValid &&
                isMobileNumberValid &&
                isEmailValid) {
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
                    userId: Uuid().v1(),
                    countryCode: state.selectedCountrycode,
                    designation: state.designation.getOrCrash(),
                    email: state.emailAddress.getOrCrash(),
                    firstName: state.firstName.getOrCrash(),
                    lastName: state.lastName.getOrCrash(),
                    phone: int.tryParse(state.mobileNumber.getOrCrash()),
                    predictedData: res,
                    isAdmin: state.isAdmin,
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
        );
      },
    );
  }
}
