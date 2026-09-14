import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/cubit/theme_cubit/theme_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';

class ThemeModeScreen extends StatefulWidget {
  const ThemeModeScreen({super.key});

  @override
  State<ThemeModeScreen> createState() => _ThemeModeScreenState();
}

class _ThemeModeScreenState extends State<ThemeModeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        title: AppTheme.plantCareAILogo(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        leading: AppTheme.backButton(context),
      ),

      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDarkMode = state.isDarkMode;

          return Padding(
            padding: EdgeInsets.all(16.r),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  l10n.appearance,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                SizedBox(height: 8.h),

                Text(
                  l10n.chooseThemeDescription,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),

                SizedBox(height: 24.h),

                _themeCard(
                  context: context,
                  title: l10n.lightMode,
                  subtitle: l10n.lightModeDescription,
                  icon: Icons.light_mode_rounded,
                  selected: !isDarkMode,
                  onTap: () {
                    if (isDarkMode) {
                      context.read<ThemeCubit>().changeTheme(false);
                    }
                  },
                ),

                SizedBox(height: 12.h),

                _themeCard(
                  context: context,
                  title: l10n.darkMode,
                  subtitle: l10n.darkModeDescription,
                  icon: Icons.dark_mode_rounded,
                  selected: isDarkMode,
                  onTap: () {
                    if (!isDarkMode) {
                      context.read<ThemeCubit>().changeTheme(true);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _themeCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: EdgeInsets.all(16.r),

        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.12)
              : Theme.of(context).cardColor,

          borderRadius: BorderRadius.circular(18.r),

          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.withOpacity(0.25),
            width: selected ? 1.5 : 1,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,

              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withOpacity(0.15)
                    : Colors.grey.withOpacity(0.1),

                borderRadius: BorderRadius.circular(14.r),
              ),

              child: Icon(
                icon,
                color: selected
                    ? AppColors.primary
                    : Theme.of(context).iconTheme.color,
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),

              width: 24.w,
              height: 24.w,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: selected ? AppColors.primary : Colors.transparent,

                border: Border.all(
                  color: selected ? AppColors.primary : Colors.grey,
                  width: 2,
                ),
              ),

              child: selected
                  ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
