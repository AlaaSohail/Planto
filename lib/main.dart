import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_care/l10n/l10n.dart';
import 'package:plant_care/presentations/screens/welcome_screens/SplashScreen.dart';
import 'package:plant_care/presentations/themes/app_theme.dart';
import 'controllers/cache/cache_helper.dart';
import 'controllers/core/api/dio_consumer.dart';
import 'controllers/cubit/ai_cubit/ai_cubit.dart';
import 'controllers/cubit/community_cubit/community_cubit.dart';
import 'controllers/cubit/local_cubit/locale_cubit.dart';
import 'controllers/cubit/plant_cubit/plant_cubit.dart';
import 'controllers/cubit/user_cubit/user_cubit.dart';
import 'controllers/cubit/weather_cubit/weather_cubit.dart';
import 'controllers/services/service_locator.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
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
        BlocProvider(create: (_) => LocaleCubit()..loadLanguage()),
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
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              locale: locale,

              theme: AppTheme.light(locale),
              darkTheme: AppTheme.dark(locale),

              themeMode: ThemeMode.system,

              supportedLocales: L10n.languages,

              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
