import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isUpperCase;
  final bool showFullDescription;

  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final TextStyle? style;
  final TextOverflow? overflow;
  final Color? textColor;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final String? fontFamily;
  final double? lineHeight;
  final List<Shadow>? shadows;
  const BaseText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.style,
    this.overflow = TextOverflow.ellipsis,
    this.textColor,
    this.textDecoration = TextDecoration.none,
    this.fontSize = 16,
    this.isUpperCase = false,
    this.fontWeight,
    this.letterSpacing,
    this.maxLines = 5,
    this.fontFamily = 'SfPro',
    this.lineHeight,
    this.shadows,
    this.showFullDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isUpperCase ? text.toUpperCase() : text,
      textAlign: textAlign,
      textScaler: TextScaler.linear(1),
      overflow: showFullDescription ? null : overflow,
      maxLines: showFullDescription ? null : maxLines,
      style: style ??
          TextStyle(
            height: lineHeight,
            shadows: shadows,
            color: textColor ?? AppColors.black,
            decoration: textDecoration,
            decorationColor: textColor,
            fontFamily: fontFamily,
            fontSize: getFontSize(fontSize),
            letterSpacing: letterSpacing ?? 0.5,
            fontWeight: fontWeight ?? FontWeight.w400,
          ),
    );
  }
}
