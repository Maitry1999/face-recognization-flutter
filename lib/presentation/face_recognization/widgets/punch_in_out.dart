import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/core/network/hive_box_names.dart';
import 'package:attandence_system/infrastructure/punch_in_out/punch_in_out_entity.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:developer' as dev;

class PunchINOutWidget extends StatelessWidget {
  const PunchINOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> updatePunchInOutTime(String userId, BuildContext context,
      {required bool isPunchIn}) async {
    // Open the Hive box
    var box = Hive.box<AccountEntity>(BoxNames.currentUser);

    // Find the index of the user
    int userIndex =
        box.values.toList().indexWhere((account) => account.userId == userId);

    // Check if the user exists
    if (userIndex != -1) {
      // Get the existing AccountEntity
      AccountEntity existingUser = box.getAt(userIndex)!;

      // Get the user's existing punch in/out records or initialize an empty list
      List<PunchInOutRecord> punchInOutRecords =
          existingUser.punchInOutTime ?? [];

      DateTime now = DateTime.now();

      if (isPunchIn) {
        // Check for any existing punch-in records without a punch-out
        if (punchInOutRecords.isNotEmpty &&
            punchInOutRecords.last.punchOut == null) {
          // Log or show a message indicating the user forgot to punch out
          dev.log(
              'Warning: User ${existingUser.firstName} ${existingUser.lastName} forgot to punch out for the last session.');
          showError(
                  message:
                      'Note: You have not punched out for your last session.')
              .show(context);
          // Return early to avoid adding a new punch-in record
          return;
        }
        // Punch-In: Add a new entry for punch-in (start a new record)
        punchInOutRecords.add(
          PunchInOutRecord(now, null),
        ); // Set punch-out to null initially
      } else {
        // Punch-Out: Update the latest punch-in record's punch-out time
        if (punchInOutRecords.isNotEmpty) {
          PunchInOutRecord lastRecord = punchInOutRecords.last;

          // Check if the last record's punch-in and punch-out times are the same
          if (lastRecord.punchOut != null) {
            // Handle the case where punch-out is clicked without a matching punch-in
            dev.log('Error: Cannot punch out without a matching punch in.');
            showError(
                    message:
                        'Cannot punch out without a punch in. Please do punch in first.')
                .show(context);
            return;
          }

          // Update the punch-out time to the current time
          punchInOutRecords[punchInOutRecords.length - 1] =
              PunchInOutRecord(lastRecord.punchIn, now);
        } else {
          // No punch-in records exist, can't punch out without punch-in
          dev.log('Error: Cannot punch out without any punch in records.');
          showError(
            message:
                'Cannot punch out without a punch in record. Please do punch in first.',
          ).show(context);
          return;
        }
      }

      // Create a new AccountEntity with the updated punch in/out records
      AccountEntity updatedUser = AccountEntity(
        existingUser.userId,
        existingUser.firstName,
        existingUser.lastName,
        existingUser.email,
        existingUser.countryCode,
        existingUser.phone,
        existingUser.designation,
        punchInOutRecords, // Updated punch in/out records
        existingUser.predictedData,
        existingUser.isAdmin,
      );

      // Save the updated user back to the Hive box
      await box.putAt(userIndex, updatedUser);

      // Log the update
      dev.log(
          'Updated Punch ${isPunchIn ? 'In' : 'Out'} Time for User ${existingUser.firstName} ${existingUser.lastName}: $punchInOutRecords');

      // Navigate to success screen
      context.router
          .push(PageRouteInfo(SuccessScreen.name,
              args: SuccessScreenArgs(
                  message:
                      'Updated Punch ${isPunchIn ? 'In' : 'Out'} Time for Employee ${existingUser.firstName} ${existingUser.lastName}')))
          .then((value) async {
        context.router.popUntil((route) => route.isFirst);
      });
    } else {
      // Log if the user is not found
      dev.log('User with userId: $userId not found in Hive.');
    }
  }
}
