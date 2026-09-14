import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/cubit/local_cubit/locale_cubit.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'nativeName': 'English', 'code': 'en'},
    {'name': 'Arabic', 'nativeName': 'العربية', 'code': 'ar'},
    {'name': 'Hebrew', 'nativeName': 'עברית', 'code': 'he'},
  ];

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.watch<LocaleCubit>().state.languageCode;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        title: AppTheme.plantCareAILogo(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,

        leading: AppTheme.backButton(context),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ListView.separated(
          itemCount: languages.length,

          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey.withOpacity(0.2));
          },

          itemBuilder: (context, index) {
            final language = languages[index];

            final String code = language['code']!;
            final String nativeName = language['nativeName']!;

            final bool isSelected = currentLanguage == code;

            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),

              title: Text(
                nativeName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),

              trailing: isSelected
                  ? Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                      size: 24.sp,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      color: Colors.grey,
                      size: 24.sp,
                    ),

              onTap: () async {
                await context.read<LocaleCubit>().changeLanguage(code);
              },
            );
          },
        ),
      ),
    );
  }
}
