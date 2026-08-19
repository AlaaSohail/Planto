import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class CodeValidateField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? previousFocus;
  final FocusNode? focusNode;

  const CodeValidateField({
    super.key,
    required this.controller,
    this.previousFocus,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68.h,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        focusNode: focusNode,
        maxLength: 1,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppColors.textPrimary,

        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],

        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && previousFocus != null) {
            previousFocus!.requestFocus();
          }
        },

        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(color: AppColors.textPrimary),

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),

          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primary, width: 0.5.w),
          ),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primary, width: 1.w),
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
            fontSize: 10.sp,
          ),
        ),

        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              value.length != 1 ||
              value.length > 1) {
            return '';
          }
          return null;
        },
      ),
    );
  }
}
