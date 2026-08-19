import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppButtonTheme {
  static ElevatedButtonThemeData get theme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }

  static ElevatedButtonThemeData get themeSecondary {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary.withOpacity(0.1),
        foregroundColor: Colors.transparent,
        elevation: 0,

        shadowColor: AppColors.secondary.withOpacity(0.1),

        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: AppColors.textSecondary, width: 0.5.r),
        ),
      ),
    );
  }

  static ElevatedButtonThemeData get themeTertiary {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error.withOpacity(0.1),
        foregroundColor: Colors.transparent,
        shadowColor: AppColors.error.withOpacity(0.1),
        elevation: 0,
        minimumSize: Size(double.infinity, 56.h),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: AppColors.error, width: 0.5.r),
        ),
      ),
    );
  }
}
