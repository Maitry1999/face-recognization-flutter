import 'dart:developer';

import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/domain/auth/account_failure.dart';
import 'package:attandence_system/domain/auth/auth_value_objects.dart';
import 'package:attandence_system/domain/auth/i_auth_facade.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:attandence_system/presentation/services/ml_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:uuid/uuid.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

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
            if (state.profileImagePath.isEmpty) {
              await showError(message: 'Please select your profile image')
                  .show(e.context);
            }
            if (isFirstNameValid &&
                isLastNameValid &&
                isMobileNumberValid &&
                isEmailValid &&
                state.profileImagePath.isNotEmpty) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  authFailureOrSuccessOption: none(),
                ),
              );
              var boundingBoxes = await e.context.router.push<List>(
                PageRouteInfo(
                  FaceDetectorView.name,
                  args: FaceDetectorViewArgs(isUserRegistring: true),
                ),
              );

              if (boundingBoxes != null) {
                log('Received bounding boxes: $boundingBoxes');
                getIt<MLService>()
                    .setCurrentPrediction(boundingBoxes[0], boundingBoxes[1]);
                Face predictedFace = boundingBoxes[1];

                log('message : ${getIt<MLService>().predictedData}');
                failureOrSuccess = await _authFacade.registerUserData(
                  Account(
                    userId: Uuid().v1(),
                    countryCode: state.selectedCountrycode,
                    designation: state.designation.getOrCrash(),
                    email: state.emailAddress.getOrCrash(),
                    faceData: predictedFace.landmarks.toString(),
                    firstName: state.firstName.getOrCrash(),
                    lastName: state.lastName.getOrCrash(),
                    phone: int.tryParse(state.mobileNumber.getOrCrash()),
                    profileImage: state.profileImagePath,
                    predictedData: getIt<MLService>().predictedData,
                    boundingBox: predictedFace.boundingBox.toString(),
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
          changeProfileImage: (value) async {
            emit(
              state.copyWith(
                profileImagePath: value.profileImagePath,
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
          start: (Start value) async {
            // emit(
            //   state.copyWith(
            //     initializing: true,
            //   ),
            // );

            // await state.cameraService.initialize().then(
            //       (value) => emit(
            //         state.copyWith(
            //           initializing: false,
            //         ),
            //       ),
            //     );
            // state.faceDetectorService.initialize();
            // add(AddNewMemberEvent.frameFaces());
          },
          frameFaces: (FrameFaces value) async {
            // emit(state.copyWith(imageSize: state.cameraService.getImageSize()));

            // state.cameraService.cameraController
            //     ?.startImageStream((image) async {
            //   if (state.cameraService.cameraController != null) {
            //     if (state.detectingFaces) return;
            //     // emit(state.copyWith(detectingFaces: true));

            //     try {
            //       await state.faceDetectorService.detectFacesFromImage(
            //         image,
            //         state.cameraService.cameraController,
            //       );

            //       if (state.faceDetectorService.faces.isNotEmpty) {
            //         log('${state.faceDetectorService.faces.asMap()}');
            //         // emit(state.copyWith(
            //         //     faceDetected: state.faceDetectorService.faces.first));
            //         // // setState(() {
            //         // //   faceDetected = _faceDetectorService.faces[0];
            //         // // });
            //         // if (state.saving) {
            //         //   state.mlService
            //         //       .setCurrentPrediction(image, state.faceDetected);
            //         //   emit(state.copyWith(saving: false));
            //         // }
            //       } else {
            //         print('face is null');
            //         //emit(state.copyWith(faceDetected: null));
            //       }

            //       //emit(state.copyWith(detectingFaces: false));
            //     } catch (e) {
            //       print('Error _faceDetectorService face => $e');
            //       // emit(state.copyWith(detectingFaces: false));
            //     }
            //   }
            // });
          },
          isNewMemberAdmin: (IsNewMemberAdmin value) async {
            emit(state.copyWith(isAdmin: value.isAdmin));
          },
        );
      },
    );
  }
}
