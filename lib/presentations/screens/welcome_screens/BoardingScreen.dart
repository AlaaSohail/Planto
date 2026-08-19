import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../controllers/cache/cache_helper.dart';
import '../../../controllers/services/service_locator.dart';
import '../../themes/app_button_theme.dart';
import 'WelcomeScreen.dart';

class OnBoardingContent {
  LottieBuilder image;
  String title;
  String subtitle;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  int currentPage = 0;

  final List<OnBoardingContent> contents = [
    OnBoardingContent(
      image: Lottie.asset("assets/lottie/Plant_Scanning.json"),
      title: "Identify Plants Instantly",
      subtitle:
          "Point your camera at any plant and get instant identification with detailed care instructions in seconds.",
    ),

    OnBoardingContent(
      image: Lottie.asset("assets/lottie/Animated_plant_loader.json"),
      title: "Smart Plant Care",
      subtitle:
          "Get personalized care recommendations based on your plant and its needs.",
    ),

    OnBoardingContent(
      image: Lottie.asset("assets/lottie/ai.json"),
      title: "AI Plant Doctor",
      subtitle:
          "Diagnose diseases, pests, and deficiencies with our advanced AI and get expert treatment recommendations instantly.",
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF7FBF5),

      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => WelcomeScreen()),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // =========================
            // PAGES
            // =========================
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: contents.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  final content = contents[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),

                    child: Column(
                      children: [
                        // LOTTIE
                        Expanded(
                          flex: 6.r.toInt(),
                          child: Center(child: content.image),
                        ),

                        // TITLE
                        Text(
                          content.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // SUBTITLE
                        Text(
                          content.subtitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.grey.shade600,
                            height: 1.5.h,
                          ),
                        ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 25.h),

            // =========================
            // NEXT BUTTON
            // =========================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),

              child: MainButton(
                onPressed: () async {
                  if (currentPage < contents.length - 1) {
                    await getIt<CacheHelper>().saveData(
                  key: "onBoarding",
                  value: true,
                  );
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => WelcomeScreen()),
                    );
                  }
                },
                content: currentPage == contents.length - 1
                    ? "Get Started"
                    : "Next",
                mainAxisSize: MainAxisSize.max,
                buttonStyle: AppButtonTheme.theme.style!,
                textStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
