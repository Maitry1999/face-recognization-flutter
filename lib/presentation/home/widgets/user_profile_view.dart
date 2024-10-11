
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          PageRouteInfo(
            FaceDetectorView.name,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: getSize(10),
          vertical: getSize(20),
        ),
        decoration: BoxDecoration(
          color: AppColors.green.withOpacity(0.3),
          border: Border.all(color: AppColors.green),
          borderRadius: BorderRadius.circular(getSize(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     CircleAvatar(
            //       radius: 25,
            //       backgroundColor: AppColors.green,
            //       child: CircleAvatar(
            //         radius: 24,
            //         backgroundImage: FileImage(
            //           File(getCurrentUser().profileImage ?? ""),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: getSize(10),
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           BaseText(
            //             text:
            //                 'Employee Name : ${getCurrentUser().firstName ?? ""} ${getCurrentUser().lastName ?? ""}',
            //             fontSize: 14,
            //             fontWeight: FontWeight.w600,
            //           ),
            //           BaseText(
            //             text: 'Email : ${getCurrentUser().email ?? ""}',
            //             fontSize: 14,
            //           ),
            //           BaseText(
            //             text:
            //                 'Mobile No. : +${getCurrentUser().countryCode ?? ""} ${getCurrentUser().phone ?? ""}',
            //             fontSize: 14,
            //           ),
            //           BaseText(
            //             text:
            //                 'Designation : ${getCurrentUser().designation ?? ""}',
            //             fontSize: 14,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
