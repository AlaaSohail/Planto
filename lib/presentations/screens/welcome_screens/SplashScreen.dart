import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/presentations/screens/welcome_screens/BoardingScreen.dart';

import '../../../controllers/cache/cache_helper.dart';
import '../../../controllers/paths/ApiEndpoints.dart';
import '../../../controllers/services/service_locator.dart';
import '../nav_bar_screens/NavBarScreen.dart';
import 'WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final token = getIt<CacheHelper>().getData(key: ApiKeys.token);

    final id = getIt<CacheHelper>().getData(key: ApiKeys.id);
    final isOnBoarding = getIt<CacheHelper>().getData(key: "onBoarding");

    if (token != null && token.toString().isNotEmpty && id != null) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => const NavBarScreen()),
      );
    } else if (isOnBoarding != true) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => OnBoardingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfff7fbf5),

      body: Stack(
        children: [
          // المحتوى الرئيسي
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSplashImage(size),
                SizedBox(height: 24.h),

                _buildSubtitle(context),
              ],
            ),
          ),

          // اللودينج في الأسفل
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SpinKitSpinningLines(
                color: Theme.of(context).primaryColor,
                size: 30.sp,
              ).animate().fadeIn(delay: 1200.ms).scale(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashImage(Size size) {
    return Image.asset("assets/images/logo.png", width: size.width * 0.6)
        .animate()
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.5, end: 0, duration: 700.ms);
  }

  Widget _buildSubtitle(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CARE  ",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildDot(context),
            Text(
              "  PROTECT  ",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildDot(context),
            Text(
              "  GROW",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 1000.ms)
        .slideY(begin: 0.5, end: 0, duration: 700.ms);
  }

  Widget _buildDot(BuildContext context) {
    return Container(
      height: 4.h,
      width: 4.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
