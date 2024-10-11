import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final Widget? leading;
  final double elevation;
  final String title;
  final Widget? customTitle;
  final List<Widget>? actions;
  final double? leadingWidth;
  final bool isRoundedCorner;
  final bool? centerTile;
  final PreferredSizeWidget? bottom;
  final Function()? onPressed;
  final double? titleSpacing;
  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTile,
    this.leading,
    this.actions,
    this.leadingWidth,
    this.isRoundedCorner = true,
    this.elevation = 0.0,
    this.customTitle,
    this.onPressed,
    this.bottom,
    this.titleSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: leading,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: true,
      shadowColor: Color(0xFFE1E1E1),
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: elevation,
      titleSpacing: titleSpacing,
      leadingWidth: leadingWidth,
      shape: isRoundedCorner
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  getSize(12),
                ),
                bottomRight: Radius.circular(
                  getSize(12),
                ),
              ),
            )
          : null,
      title: customTitle ??
          BaseText(
            fontSize: 16,
            text: title,
            fontWeight: FontWeight.w600,
          ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      actions: actions,
      centerTitle: centerTile ?? true,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);

  // _buildLeadingView(BuildContext context) {
  //   return IconButton(
  //     padding: EdgeInsets.zero,
  //     onPressed: onPressed ??
  //         () {
  //           context.router.back();
  //         },
  //     icon: Icon(
  //       Icons.arrow_back_ios_rounded,
  //     ),
  //   );
  // }
}
