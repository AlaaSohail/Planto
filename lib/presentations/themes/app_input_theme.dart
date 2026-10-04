import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/core/functions/IsArabic.dart';

import 'app_colors.dart';

class AppInputTheme {
  // =========================
  // Light Theme
  // =========================
  static String _bodyFont(Locale locale) {
    return locale.languageCode == 'ar' ? 'Cairo' : 'Nunito';
  }
  static InputDecorationTheme get theme => InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,

    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: AppColors.primary, width: 2.w),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: Colors.red, width: 1.w),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: Colors.red, width: 2.w),
    ),

    hintStyle: TextStyle(
      fontFamily: Locale('ar').languageCode == 'ar' ? 'Cairo' : 'Nunito',
      fontSize: 14.sp,
      color: Colors.grey,
    ),

    labelStyle: TextStyle(
      fontFamily: Locale('ar').languageCode == 'ar' ? 'Cairo' : 'Nunito',
      fontSize: 14.sp,
      color: Colors.grey,
    ),

    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
  );

  // =========================
  // Dark Theme
  // =========================

  static InputDecorationTheme get dark => InputDecorationTheme(
    filled: true,
    fillColor: Color(0xff265d40).withOpacity(0.5),

    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: AppColors.primary, width: 1.w),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: Colors.redAccent, width: 1.w),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: Colors.redAccent, width: 2.w),
    ),

    hintStyle: TextStyle(
      fontFamily: Locale('ar').languageCode == 'ar' ? 'Cairo' : 'Nunito',
      fontSize: 14.sp,
      color: Colors.white60,
    ),

    labelStyle: TextStyle(
      fontFamily: Locale('ar').languageCode == 'ar' ? 'Cairo' : 'Nunito',
      fontSize: 14.sp,
      color: Colors.white70,
    ),

    prefixIconColor: Colors.white70,
    suffixIconColor: Colors.white70,
  );
}
