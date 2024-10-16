import 'package:attandence_system/application/add_new_member/add_new_member_bloc.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/utils/app_focus.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/common/widgets/common_country_code_picker.dart';
import 'package:attandence_system/presentation/common/widgets/custom_appbar.dart';
import 'package:attandence_system/presentation/common/widgets/custom_text_field.dart';
import 'package:attandence_system/presentation/core/buttons/common_button.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'AddMemberView')
class AddMemberView extends StatelessWidget {
  final bool isAdmin;

  const AddMemberView({
    super.key,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddNewMemberBloc>()
        ..add(AddNewMemberEvent.isNewMemberAdmin(isAdmin, [])),
      child: BlocConsumer<AddNewMemberBloc, AddNewMemberState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Add New ${state.isAdmin ? "Admin" : "Member"}',
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
                      onPressed: () async {
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
              (r) async {
                showSuccess(message: 'Employee added successfully.')
                    .show(context)
                    .then(
                  (value) {
                    context.router.popUntil(
                      (route) => route.isFirst,
                    );
                    // context.router.maybePop(
                    //     '${state.firstName.getOrCrash()} ${state.lastName.getOrCrash()}');
                  },
                );
              },
            ),
          );
        },
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
