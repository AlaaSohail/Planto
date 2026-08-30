import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/MainAppBar.dart';
import 'app_button_theme.dart';
import 'app_colors.dart';
import 'app_input_theme.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor: Color(0xffF3EDE6),

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),

    textTheme: AppTextTheme.textTheme,

    inputDecorationTheme: AppInputTheme.theme,

    elevatedButtonTheme: AppButtonTheme.theme,
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    scaffoldBackgroundColor: Colors.transparent,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    textTheme: AppTextTheme.textTheme,

    inputDecorationTheme: AppInputTheme.theme,

    elevatedButtonTheme: AppButtonTheme.theme,
  );

  static Widget plantCareAILogo([Color color = const Color(0xff1e3e24)]) {
    return MultiColorText(
      spans: [
        TextSpanConfig(
          text: "Planto.",
          style: TextStyle(
            color: color,
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            fontFamily: "Inter",
          ),
        ),
      ],
    );
  }

  static Widget backButton(BuildContext context, {VoidCallback? onPressed}) {
    return IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,

      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Theme.of(context).primaryColor,
        size: 28.sp,
      ),
    );
  }
}
