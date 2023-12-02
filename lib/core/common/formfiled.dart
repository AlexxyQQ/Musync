import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/constants.dart';

class KTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final TextStyle? contentStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? errorTextStyle;
  final bool? enableIMEPersonalizedLearning;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final Color? fillColor; // Added parameter for fill color
  final Widget? prefixIcon; // Added parameter for prefix icon
  final Widget? suffixIcon; // Added parameter for suffix icon
  final void Function()? onSuffixTap; // Added parameter for suffix tap
  List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextAlign? textAlign;

  KTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.enableIMEPersonalizedLearning = true,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.prefixIcon, // Initialize the new parameter
    this.suffixIcon, // Initialize the new parameter
    this.onSuffixTap, // Initialize the new parameter
    this.contentStyle,
    this.hintTextStyle,
    this.labelTextStyle,
    this.fillColor,
    this.errorTextStyle,
    this.inputFormatters,
    this.focusNode,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      enableSuggestions: enableSuggestions ?? true,
      autocorrect: autocorrect ?? true,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning ?? true,
      style: contentStyle ?? GlobalConstants.textStyle(),
      focusNode: focusNode,
      decoration: InputDecoration(
        counterText: '',
        errorStyle: errorTextStyle ?? GlobalConstants.textStyle(),
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintTextStyle ?? GlobalConstants.textStyle(),
        labelStyle: hintTextStyle ?? GlobalConstants.textStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        fillColor: fillColor ?? AppBackgroundColor.light,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        prefixIcon: prefixIcon,
        hintTextDirection: TextDirection.ltr,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixTap,
                child: suffixIcon,
              )
            : null,
      ),
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
    );
  }
}
