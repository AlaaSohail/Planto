import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextTheme {
  static String _headlineFont(Locale locale) {
    return locale.languageCode == 'ar' ? 'Cairo' : 'Inter';
  }

  static String _bodyFont(Locale locale) {
    return locale.languageCode == 'ar' ? 'Cairo' : 'Nunito';
  }

  // Light Theme
  static TextTheme textTheme(Locale locale) => TextTheme(
    headlineLarge: TextStyle(
      fontSize: 26.sp,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w900,
      fontFamily: _headlineFont(locale),
    ),
    headlineMedium: TextStyle(
      fontSize: 24.sp,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      fontFamily: _headlineFont(locale),
    ),
    headlineSmall: TextStyle(
      fontSize: 18.sp,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w400,
      fontFamily: _headlineFont(locale),
    ),
    bodyLarge: TextStyle(
      fontSize: 14.sp,
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      fontFamily: _bodyFont(locale),
    ),
    bodyMedium: TextStyle(
      fontSize: 12.sp,
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontFamily: _bodyFont(locale),
    ),
    bodySmall: TextStyle(
      fontSize: 10.sp,
      color: const Color(0xffA5D65A),
      fontWeight: FontWeight.w300,
      fontFamily: _bodyFont(locale),
    ),
  );

  // Dark Theme
  static TextTheme textThemeDark(Locale locale) => TextTheme(
    headlineLarge: TextStyle(
      fontSize: 26.sp,
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontFamily: _headlineFont(locale),
    ),
    headlineMedium: TextStyle(
      fontSize: 24.sp,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: _headlineFont(locale),
    ),
    headlineSmall: TextStyle(
      fontSize: 18.sp,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontFamily: _headlineFont(locale),
    ),
    bodyLarge: TextStyle(
      fontSize: 14.sp,
      color: Colors.white70,
      fontWeight: FontWeight.w600,
      fontFamily: _bodyFont(locale),
    ),
    bodyMedium: TextStyle(
      fontSize: 12.sp,
      color: Colors.white70,
      fontWeight: FontWeight.w500,
      fontFamily: _bodyFont(locale),
    ),
    bodySmall: TextStyle(
      fontSize: 10.sp,
      color: const Color(0xffA5D65A),
      fontWeight: FontWeight.w300,
      fontFamily: _bodyFont(locale),
    ),
  );
}