import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:attandence_system/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  //final FocusNode focusNode = FocusNode();
  const CustomTextField({
    super.key,
    this.inputFormatters,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.decoration,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.prefixIcon,
    this.validator,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.errorMaxLines,
    this.suffixIcon,
    this.maxLength,
    this.obscureText = false,
    this.focusNode,
  });

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? initialValue;
  final Function(String)? onChanged;
  final InputDecoration? decoration;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final String? Function(String?, BuildContext)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? errorMaxLines;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final bool obscureText;
  final int? minLines;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black.withOpacity(0.2)),
      borderRadius: BorderRadius.circular(getSize(10)),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black.withOpacity(0.2)),
      borderRadius: BorderRadius.circular(getSize(10)),
    );
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: BorderRadius.circular(getSize(10)),
    );
    if (focusNode != null) {
      return getCommonTextFieldMethod(
          context, border, focusedBorder, errorBorder);
    } else {
      return getCommonTextFieldMethod(
          context, border, focusedBorder, errorBorder);
    }
  }

  Column getCommonTextFieldMethod(
      BuildContext context,
      OutlineInputBorder border,
      OutlineInputBorder focusedBorder,
      OutlineInputBorder errorBorder) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          BaseText(
            text: labelText ?? "",
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: getSize(8)),
        ],
        TextFormField(
          validator: (inputString) {
            return validator?.call(inputString, context);
          },
          maxLength: maxLength,
          autofocus: autofocus,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          minLines: minLines,
          focusNode: focusNode,
          onTap: onTap,
          onChanged: onChanged,
          initialValue: initialValue,
          obscureText: obscureText,
          controller: controller,
          cursorColor: AppColors.green,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          maxLines: maxLines,
          decoration: decoration?.copyWith(
                counterStyle: TextStyle(
                  height: double.minPositive,
                ),
                filled: true,
                fillColor: AppColors.white,
                isDense: true,
                border: border,
                enabledBorder: border,
                focusedBorder: focusedBorder,
                focusedErrorBorder: errorBorder,
                errorBorder: errorBorder,
                hintStyle: const TextStyle(color: AppColors.black),
              ) ??
              InputDecoration(
                counterText: '',
                filled: true,
                fillColor: AppColors.white.withOpacity(0.2),
                hintText: hintText,
                contentPadding: EdgeInsets.symmetric(
                  vertical: getSize(12),
                  horizontal: getSize(18),
                ),
                isDense: true,

                border: border,
                enabledBorder: border,
                errorMaxLines: errorMaxLines,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                suffixIconConstraints:
                    BoxConstraints(maxWidth: getSize(80), minHeight: 0),
                focusedBorder: focusedBorder,
                focusedErrorBorder: errorBorder,
                errorBorder: errorBorder,
                // prefixIconConstraints:
                //     BoxConstraints(maxWidth: getSize(79), minHeight: 0),
                hintStyle: TextStyle(
                  color: AppColors.black.withOpacity(0.3),
                  fontSize: getFontSize(12),
                  fontFamily: 'SfPro',
                  fontWeight: FontWeight.w500,
                ),
              ),
          style: readOnly
              ? Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.black)
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
