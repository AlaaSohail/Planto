import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/MainAppBar.dart';
import 'app_button_theme.dart';
import 'app_colors.dart';
import 'app_input_theme.dart';
import 'app_text_theme.dart';

class AppTheme {
  // =========================
  // Light Theme
  // =========================

  static ThemeData light(Locale locale) => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xfff7fbf5),

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),

    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primary,
      shadowColor: Colors.transparent,
    ),

    textTheme: AppTextTheme.textTheme(locale),

    inputDecorationTheme: AppInputTheme.theme,

    elevatedButtonTheme: AppButtonTheme.theme,
  );

  // =========================
  // Dark Theme
  // =========================

  static ThemeData dark(Locale locale) => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xff0c2e1d),

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
    ),

    textTheme: AppTextTheme.textThemeDark(locale),

    inputDecorationTheme: AppInputTheme.dark,

    elevatedButtonTheme: AppButtonTheme.theme,
  );

  // =========================
  // Planto Logo
  // =========================

  static Widget plantCareAILogo(
      BuildContext context, [
        Color color = const Color(0xff1e3e24),
      ]) {
    final isLight =
        Theme.of(context).brightness == Brightness.light;

    return MultiColorText(
      spans: [
        TextSpanConfig(
          text: 'Planto.',
          style: TextStyle(
            color: isLight ? color : Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  // =========================
  // Back Button
  // =========================

  static Widget backButton(
      BuildContext context, {
        VoidCallback? onPressed,
      }) {
    return IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,

      onPressed:
      onPressed ?? () => Navigator.of(context).pop(),

      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 28.sp,
      ),
    );
  }
}