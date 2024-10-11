import 'dart:async';

import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/common/utils/app_focus.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final double borderRadius;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final VoidCallback onPressed;
  final String buttonText;
  final Widget? customWidget;
  final List<BoxShadow>? shadows;
  final Widget? iconWidget;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final double? buttonFontSize;
  final FontWeight? buttonFontWeight;
  final Widget? widget;
  final bool isSubmitting;
  const CommonButton({
    super.key,
    required this.onPressed,
    this.customWidget,
    this.borderRadius = 10,
    this.width,
    this.height,
    this.shadows,
    this.gradient,
    this.backgroundColor,
    required this.buttonText,
    this.iconWidget,
    this.buttonTextColor,
    this.buttonFontSize,
    this.buttonFontWeight,
    this.borderColor,
    this.widget,
    this.isSubmitting = false,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  bool isButtonDisabled = false;
  Timer? buttonTimer;
  void _handleButtonTap() {
    AppFocus.unfocus(context);
    if (!isButtonDisabled) {
      setState(() {
        isButtonDisabled = true;
      });

      widget.onPressed();
      // Enable the button after a specified duration (e.g., 3 seconds).
      buttonTimer = Timer(Duration(seconds: 3), () {
        setState(() {
          isButtonDisabled = false;
        });
      });
    }
  }

  @override
  void dispose() {
    buttonTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          widget.isSubmitting || isButtonDisabled ? null : _handleButtonTap,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: widget.borderColor ?? Colors.transparent),
        elevation: 0,
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        backgroundColor: widget.backgroundColor ?? AppColors.green,
        disabledBackgroundColor: widget.backgroundColor ?? AppColors.green,
        padding: EdgeInsets.zero,
        fixedSize: Size(
          getSize(widget.width ?? MediaQuery.of(context).size.width),
          getSize(
            widget.height ?? 42,
          ),
        ),
        visualDensity: VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getSize(widget.borderRadius),
          ),
        ),
      ),
      child: widget.isSubmitting
          ? SizedBox(
              height: getSize(20),
              width: getSize(20),
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            )
          : BaseText(
              text: widget.buttonText,
              fontSize: widget.buttonFontSize ?? 16,
              textAlign: TextAlign.center,
              //maxLines: 1,
              fontWeight: widget.buttonFontWeight ?? FontWeight.w500,
              textColor: widget.buttonTextColor ?? Colors.white,
            ),
    );
  }
}
