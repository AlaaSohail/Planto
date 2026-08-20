import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextTheme {
  static TextTheme get textTheme => TextTheme().copyWith(
    headlineLarge: TextStyle(
      fontSize: 26.sp,
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontFamily: "Inter",
    ),
    headlineMedium: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: "Inter",
    ),
    headlineSmall: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontFamily: "Inter",
    ),
    bodyLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontFamily: "Nunito",
    ),
    bodyMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      fontFamily: "Nunito",
    ),
    bodySmall: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w300,
      color: Color(0xffA5D65A),
      fontFamily: "Nunito",
    ),
  );
}
