import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_care/presentations/screens/auth_screens/LoginScreen.dart';
import 'package:plant_care/presentations/screens/welcome_screens/SplashScreen.dart';
import 'package:plant_care/presentations/themes/app_theme.dart';
import 'controllers/cache/cache_helper.dart';
import 'controllers/core/api/dio_consumer.dart';
import 'controllers/cubit/ai_cubit/ai_cubit.dart';
import 'controllers/cubit/community_cubit/community_cubit.dart';
import 'controllers/cubit/plant_cubit/plant_cubit.dart';
import 'controllers/cubit/user_cubit/user_cubit.dart';
import 'controllers/cubit/weather_cubit/weather_cubit.dart';
import 'controllers/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  if (Platform.isAndroid || Platform.isIOS) {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize(
      serverClientId:
          '141453372151-4lj4i23rl7m1m2fpa3mtle5t3qqckjuq.apps.googleusercontent.com',
    );
  }

  setupServiceLocator();
  await getIt<CacheHelper>().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PlantCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => UserCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => WeatherCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => AiCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (_) => CommunityCubit(DioConsumer(dio: Dio()))),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          home: SplashScreen(),
        );
      },
    );
  }
}
