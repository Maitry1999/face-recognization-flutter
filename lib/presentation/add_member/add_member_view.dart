import 'dart:io';

import 'package:attandence_system/application/add_new_member/add_new_member_bloc.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/utils/app_focus.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/common/utils/image_picker_utils.dart';
import 'package:attandence_system/presentation/common/widgets/common_country_code_picker.dart';
import 'package:attandence_system/presentation/common/widgets/custom_appbar.dart';
import 'package:attandence_system/presentation/common/widgets/custom_text_field.dart';
import 'package:attandence_system/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:attandence_system/presentation/core/buttons/common_button.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage(name: 'AddMemberView')
class AddMemberView extends StatelessWidget {
  final bool isAdmin;
  const AddMemberView({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddNewMemberBloc>()
        ..add(AddNewMemberEvent.isNewMemberAdmin(isAdmin)),
      child: BlocConsumer<AddNewMemberBloc, AddNewMemberState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Add New Member',
              isRoundedCorner: true,
            ),
            body: GestureDetector(
              onTap: () {
                AppFocus.unfocus(context);
              },
              child: Form(
                autovalidateMode: state.showErrorMessages
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: getSize(18)),
                  physics: BouncingScrollPhysics(),
                  children: [
                    getProfileImageView(state, context),
                    SizedBox(
                      height: getSize(20),
                    ),
                    firstNameTextFieldView(context, state),
                    SizedBox(
                      height: getSize(20),
                    ),
                    lasttNameTextFieldView(context, state),
                    SizedBox(
                      height: getSize(20),
                    ),
                    emailTextFieldView(context, state),
                    SizedBox(
                      height: getSize(20),
                    ),
                    designationTextFieldView(context, state),
                    SizedBox(
                      height: getSize(20),
                    ),
                    mobileNumberTextFieldView(context, state),
                    SizedBox(
                      height: getSize(30),
                    ),
                    CommonButton(
                      isSubmitting: state.isSubmitting,
                      onPressed: () {
                        context
                            .read<AddNewMemberBloc>()
                            .add(AddNewMemberEvent.addNewMember(context));
                      },
                      buttonText: 'Add',
                    ),
                    SizedBox(
                      height: getSize(20),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, AddNewMemberState state) {
          state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    badRequest: (value) => value.error,
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) {
                showSuccess(message: 'Employee added successfully.')
                    .show(context)
                    .then(
                  (value) {
                    context.router.push(
                      PageRouteInfo(
                        DashboardView.name,
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Center getProfileImageView(AddNewMemberState state, BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: getSize(50),
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              backgroundColor: AppColors.green,
              radius: getSize(48),
              backgroundImage: state.profileImagePath.isEmpty
                  ? null
                  : FileImage(
                      File(state.profileImagePath),
                    ),
              child: state.profileImagePath.isEmpty
                  ? Icon(
                      Icons.person,
                      size: getSize(50),
                      color: AppColors.white,
                    )
                  : null,
            ),
          ),
          GestureDetector(
            onTap: () {
              ImageChooserDialog().showImageChooserDialog(
                takePhotoCallback: () async {
                  String? path = await ImagePickerUtils().pickImage(
                      imageSource: ImageSource.camera, context: context);

                  if (path != null) {
                    context.read<AddNewMemberBloc>().add(
                          AddNewMemberEvent.changeProfileImage(
                            path,
                          ),
                        );
                  }
                  context.router.maybePop();
                },
                selectPhotoCallback: () async {
                  String? path = await ImagePickerUtils().pickImage(
                      imageSource: ImageSource.gallery, context: context);
                  if (path != null) {
                    context.read<AddNewMemberBloc>().add(
                          AddNewMemberEvent.changeProfileImage(
                            path,
                          ),
                        );
                  }
                  context.router.maybePop();
                },
                context: context,
              );
            },
            child: Container(
              height: getSize(30),
              width: getSize(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.10),
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.edit,
                size: getSize(14),
              ),
            ),
          )
        ],
      ),
    );
  }

  CustomTextField firstNameTextFieldView(
      BuildContext context, AddNewMemberState state) {
    return CustomTextField(
      labelText: 'First Name',
      hintText: 'First Name',
      textCapitalization: TextCapitalization.words,
      onChanged: (value) => context
          .read<AddNewMemberBloc>()
          .add(AddNewMemberEvent.firstNameChanged(value)),
      validator: (_, context) =>
          context.read<AddNewMemberBloc>().state.firstName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter first name',
                  invalidUsername: (_) => 'Please enter valid first name',
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  CustomTextField designationTextFieldView(
      BuildContext context, AddNewMemberState state) {
    return CustomTextField(
      labelText: 'Designation',
      hintText: 'Designation',
      textCapitalization: TextCapitalization.words,
      onChanged: (value) => context
          .read<AddNewMemberBloc>()
          .add(AddNewMemberEvent.designationChanged(value)),
      validator: (_, context) =>
          context.read<AddNewMemberBloc>().state.designation.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter your designation',
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  CustomTextField lasttNameTextFieldView(
      BuildContext context, AddNewMemberState state) {
    return CustomTextField(
      labelText: 'Last Name',
      hintText: 'Last Name',
      textCapitalization: TextCapitalization.words,
      onChanged: (value) => context
          .read<AddNewMemberBloc>()
          .add(AddNewMemberEvent.lastNameChanged(value)),
      validator: (_, context) =>
          context.read<AddNewMemberBloc>().state.lastName.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter last name',
                  invalidUsername: (_) => 'Please enter valid last name',
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  CustomTextField emailTextFieldView(
      BuildContext context, AddNewMemberState state) {
    return CustomTextField(
      labelText: 'Email Address',
      hintText: 'Email Address',
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => context
          .read<AddNewMemberBloc>()
          .add(AddNewMemberEvent.emailChanged(value)),
      validator: (_, context) =>
          context.read<AddNewMemberBloc>().state.emailAddress.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter email',
                  invalidEmail: (_) => 'Please enter valid email address',
                  orElse: () => null,
                ),
                (_) => null,
              ),
    );
  }

  CustomTextField mobileNumberTextFieldView(
      BuildContext context, AddNewMemberState state) {
    return CustomTextField(
      labelText: 'Mobile Number',
      hintText: 'Mobile Number',
      keyboardType: TextInputType.phone,
      errorMaxLines: 2,
      //focusNode: state.mobileNumberFocusNode,
      onChanged: (value) => context
          .read<AddNewMemberBloc>()
          .add(AddNewMemberEvent.mobileNumberChanged(value)),
      validator: (_, context) =>
          context.read<AddNewMemberBloc>().state.mobileNumber.value.fold(
                (f) => f.maybeMap(
                  empty: (value) => 'Please enter mobile number',
                  invalidMobileNumber: (_) =>
                      'Phone number should be between 8 and 15 digits',
                  orElse: () => null,
                ),
                (_) => null,
              ),
      prefixIcon: CommonCountryCodePicker(
        initialSelection: state.selectedCountrycode,
        onChanged: (countryCode) {
          context.read<AddNewMemberBloc>().add(
                AddNewMemberEvent.selectCountryCode(countryCode.phoneCode),
              );
        },
      ),
    );
  }
}
