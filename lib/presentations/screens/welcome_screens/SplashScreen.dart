import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/controllers/core/functions/IsArabic.dart';
import 'package:plant_care/controllers/cubit/task_cubit/task_cubit.dart';
import 'package:plant_care/presentations/screens/welcome_screens/BoardingScreen.dart';

import '../../../controllers/cache/cache_helper.dart';
import '../../../controllers/cubit/ai_cubit/ai_cubit.dart';
import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../../controllers/cubit/weather_cubit/weather_cubit.dart';
import '../../../controllers/paths/ApiEndpoints.dart';
import '../../../controllers/services/location_service.dart';
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

  Future<void> _loadLocationData() async {
    try {
      final position = await LocationService.getCurrentLocation();

      if (!mounted || position == null) return;

      // Weather
      await context.read<WeatherCubit>().getWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (!mounted) return;

      final shouldUpdate = await LocationService.shouldUpdateLocation();

      if (!mounted) return;

      if (shouldUpdate) {
        await context.read<UserCubit>().updateLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        await LocationService.saveLocationUpdateTime();
      }

      if (!mounted) return;

      context.read<WeatherCubit>().getLocation(
        position.latitude,
        position.longitude,
      );
    } catch (e, stackTrace) {
      debugPrint('❌ Location/Weather error: $e');
      debugPrint('📍 StackTrace:\n$stackTrace');
    }
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
      context.read<UserCubit>().getUserProfile();

      context.read<PlantCubit>().getPlant();

      _loadLocationData();
      context.read<TaskCubit>().getTodayTasks();

      context.read<AiCubit>().getDailyTip();
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
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            // المحتوى الرئيسي
            Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/back_ground_image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSplashImage(size),
                    SizedBox(height: 24.h),

                    _buildSubtitle(context),
                  ],
                ),
              ),
            ),

            // اللودينج في الأسفل
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: SpinKitSpinningLines(
                  color: Colors.white,
                  size: 30.sp,
                ).animate().fadeIn(delay: 1200.ms).scale(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplashImage(Size size) {
    return Image.asset("assets/images/logo.png", width: size.width * 0.6)
        .animate()
        .fadeIn(duration: 1500.ms)
        .slideY(begin: 0.2, end: 0, duration: 700.ms);
  }

  Widget _buildSubtitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
              "CARE TODAY,",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w300,
              ),
            )
            .animate()
            .fadeIn(delay: 1100.ms)
            .slideY(begin: 0.5, end: 0, duration: 700.ms),
        Text(
              " GREENER TOMORROW",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w300,
              ),
            )
            .animate()
            .fadeIn(delay: 2000.ms)
            .slideY(begin: 0.7, end: 0, duration: 900.ms),
      ],
    );
  }
}
