import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffix,
    this.prefix,
    this.obscureText,
    this.validator,
    this.readOnly,
    this.initialValue,
    required TextInputType keyboardType,
  });

  InkWell? suffix;
  Widget? prefix;
  String hintText;
  bool? obscureText;
  String? Function(String?)? validator;
  TextEditingController controller;
  TextInputType? keyboardType;
  bool? readOnly;
  String? initialValue;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,

      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 0.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5.w, color: Colors.red),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5.w, color: Colors.red),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.w),
        ),
        errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
        suffixIcon: widget.suffix,

        prefixIcon: widget.prefix,
      ),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
      ),
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
