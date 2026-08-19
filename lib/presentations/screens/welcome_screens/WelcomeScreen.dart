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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfff7fbf5),
      appBar: AppBar(
        leadingWidth: 16.w,
        title: AppTheme.plantCareAILogo(Colors.white),
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
                        content: "🌿 Your garden, reimagined",
                        textStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Grow smarter",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'with AI',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Identify, diagnose, and care for your plants with the power of artificial intelligence. Join 2M+ plant_cubit lovers.",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 4.h),

                      MainButton(
                        buttonStyle: AppButtonTheme.theme.style!.copyWith(),
                        content: "Create Free Account",
                        textStyle: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => RegisterScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_forward, color: Colors.black),
                        mainAxisSize: MainAxisSize.max,
                      ),
                      SizedBox(height: 20.h),
                      MainButton(
                        buttonStyle: AppButtonTheme.themeSecondary.style!
                            .copyWith(),
                        content: "Sign In",
                        textStyle: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        mainAxisSize: MainAxisSize.max,
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: InkWell(
                          autofocus: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => NavBarScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Continue as Guest",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary,
                                  decorationThickness: 2,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        spacing: 16.r,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WelcomeStatistics(
                            title: "Plants",
                            value: "100",
                            unit: "K+",
                          ),
                          WelcomeStatistics(
                            title: "Users",
                            value: "2",
                            unit: "M+",
                          ),
                          WelcomeStatistics(
                            title: "Ratings",
                            value: "4.9",
                            unit: "⭐",
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
