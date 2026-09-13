import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/services/service_locator.dart';
import 'package:plant_care/presentations/screens/auth_screens/LoginScreen.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/HomeScreen.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';
import 'package:plant_care/presentations/themes/app_theme.dart';
import 'package:plant_care/presentations/widgets/BadgeContainer.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../widgets/WelcomeStatistics.dart';
import '../auth_screens/RegisterScreen.dart';
import '../nav_bar_screens/NavBarScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 16.w,
        title: AppTheme.plantCareAILogo(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5), // ✨ أسود 40% شفاف
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0).r,
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BadgeContainer(
                        color: Colors.green,
                        content: l10n.welcomeGardenReimagined,
                        textStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        l10n.welcomeGrowSmarter,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.welcomeWithAI,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        l10n.welcomeDescription,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      MainButton(
                        buttonStyle: AppButtonTheme.theme.style!.copyWith(),
                        content: l10n.welcomeCreateFreeAccount,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => RegisterScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        mainAxisSize: MainAxisSize.max,
                      ),
                      SizedBox(height: 20.h),
                      MainButton(
                        buttonStyle: AppButtonTheme.themeSecondary.style!.copyWith(),
                        content: l10n.welcomeSignIn,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => LoginScreen(),
                            ),
                          );
                        },
                        mainAxisSize: MainAxisSize.max,
                      ),
                      SizedBox(height: 20.h),

                      SizedBox(height: 20.h),

                      Row(
                        spacing: 16.r,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WelcomeStatistics(
                            title: l10n.welcomePlants,
                            value: l10n.welcomePlantsValue,
                            unit: l10n.welcomePlantsUnit,
                          ),
                          WelcomeStatistics(
                            title: l10n.welcomeUsers,
                            value: l10n.welcomeUsersValue,
                            unit: l10n.welcomeUsersUnit,
                          ),
                          WelcomeStatistics(
                            title: l10n.welcomeRatings,
                            value: l10n.welcomeRatingsValue,
                            unit: l10n.welcomeRatingsUnit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
