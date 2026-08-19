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
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 12, bottom: 12),
      child: InkWell(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Image.asset(
            'assets/images/back.png',
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
