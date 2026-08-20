import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:plant_care/controllers/cubit/weather_cubit/weather_cubit.dart';
import 'package:plant_care/controllers/services/service_locator.dart';
import 'package:plant_care/presentations/screens/ai_chat_screen/AiChatScreen.dart';
import 'package:plant_care/presentations/widgets/BadgeContainer.dart';
import 'package:plant_care/presentations/widgets/TipCard.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../controllers/cache/cache_helper.dart';
import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../../controllers/services/location_service.dart';
import '../../themes/app_colors.dart';
import '../../widgets/ContainerIcons.dart' show ContainerIcons;
import '../../widgets/PlantCard.dart';
import '../../widgets/QuickActionsCard.dart';
import '../../widgets/SearchTextField.dart';
import '../../widgets/TaskCard.dart';
import '../../widgets/WeatherCard.dart';
import '../plants_screens/AddPlantManualScreen.dart';
import '../plants_screens/GetPlantScreen.dart';
import '../plants_screens/PlantDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onOpenPlants});

  final VoidCallback onOpenPlants;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  String? city = "unknown";
  String? country = "unknown";

  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>().getPlant();
    context.read<UserCubit>().getUserProfile();

    _loadLocationData();
  }

  Future<void> _loadLocationData() async {
    try {
      final position = await LocationService.getCurrentLocation();

      if (!mounted || position == null) {
        return;
      }

      // Weather
      await context.read<WeatherCubit>().getWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (!mounted) return;

      // Update user location
      final shouldUpdate =
      await LocationService.shouldUpdateLocation();

      if (shouldUpdate && mounted) {
        await context.read<UserCubit>().updateLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        await LocationService.saveLocationUpdateTime();
      }
    } catch (e) {
      debugPrint('❌ Location/Weather error: $e');

      // مهم:
      // لا نخلي فشل الإنترنت يسقط HomeScreen
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning 🌞";
    } else if (hour < 18) {
      return "Good Afternoon ☀️";
    } else {
      return "Good Evening 🌙";
    }
  }

  List<QuickAction> get quickActions => [
    QuickAction(
      title: 'Add Plant',
      icon: 'assets/images/leaf.png',
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (_) => AddPlantManualScreen()),
        );
      },
    ),
    QuickAction(
      title: 'Doctor AI',
      icon: 'assets/images/ai.png',
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (_) => AiChatScreen()),
        );
      },
    ),
    QuickAction(
      title: 'Community',
      icon: 'assets/images/society.png',
      onTap: () {
        // TODO: Open Diagnose
      },
    ),
    QuickAction(
      title: 'Care Tips',
      icon: 'assets/images/caree.png',
      onTap: () {
        // TODO: Open Care Tips
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfff7fbf5),
      appBar: AppBar(
        titleSpacing: 10.w,
        title: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            final isLoading = state is UserLoading;
            if (state is UserSuccess) {
              city = state.user.city ?? "Unknown";
              country = state.user.country ?? "Unknown";
            }

            return Skeletonizer(
              enabled: isLoading,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: isLoading
                          ? "Good Morning 🌞\n"
                          : "${getGreeting()}\n",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: isLoading
                          ? "User Name"
                          : state is UserSuccess
                          ? state.user.name
                          : "",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ContainerIcons(icon: 'assets/images/notification.png'),
          ),
        ],
        leading: Text(''),
        leadingWidth: 16.w,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchTextField(
                      controller: _searchController,
                      hintText: "Search plants, care tips..",
                      prefix: Icon(Icons.search_rounded, color: Colors.grey),
                    )
                    .animate()
                    .fadeIn(delay: 50.ms)
                    .slideY(begin: 0.5, end: 0, duration: 50.ms),
                SizedBox(height: 8.h),
                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        BlocBuilder<WeatherCubit, WeatherState>(
                          builder: (context, state) {
                            final isLoading = state is WeatherLoading;

                            if (state is WeatherError) {
                              return Text(state.message);
                            }

                            final weather = state is WeatherSuccess
                                ? state.weather
                                : null;

                            return Skeletonizer(
                              enabled: isLoading,

                              child: WeatherCard(
                                icon: weather?.icon ?? "☀️",
                                location: weather != null
                                    ? "$city, $country"
                                    : "Loading location",
                                description: weather?.description ?? "loading",
                                cTemperature:
                                    weather?.temperature.toStringAsFixed(0) ??
                                    "00",
                                fTemperature: weather?.rain.toString() ?? "0",
                                humidity: weather != null
                                    ? '${weather.humidity.toStringAsFixed(0)}%'
                                    : "00%",
                                windSpeed: weather != null
                                    ? weather.windSpeed
                                    : 0,
                                rain: weather != null
                                    ? '${weather.rain.toStringAsFixed(0)} mm'
                                    : "0 mm",
                              ),
                            );
                          },
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 100.ms)
                    .slideY(begin: 0.5, end: 0, duration: 100.ms),
                SizedBox(height: 8.h),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,

                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => AiChatScreen()),
                    );
                  },
                  child:
                      TipCard(
                            imageUrl: 'assets/images/chatbot.png',
                            color: AppColors.secondary,

                            sub:
                                "Your Fiddle Leaf Fig may need more light. Tap to learn more →",
                            title: "AI Plant Doctor",
                          )
                          .animate()
                          .fadeIn(delay: 150.ms)
                          .slideY(begin: 0.5, end: 0, duration: 150.ms),
                ),

                Text(
                      "Quick Actions",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 120.ms)
                    .slideY(begin: 0.5, end: 0, duration: 120.ms),
                SizedBox(height: 4.h),

                SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: quickActions.length,
                        itemBuilder: (context, index) {
                          final action = quickActions[index];

                          return QuickActionsCard(
                            title: action.title,
                            icon: action.icon,
                            color: Colors.white,
                            onTap: action.onTap,
                          );
                        },
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 150.ms)
                    .slideY(begin: 0.5, end: 0, duration: 150.ms),
                SizedBox(height: 8.h),

                Row(
                      children: [
                        Text(
                          "My Plants",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w900,
                                fontSize: 20.sp,
                              ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: widget.onOpenPlants,
                          child: Row(
                            children: [
                              Text(
                                "See all",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14.sp,
                                    ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14.sp,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 180.ms)
                    .slideY(begin: 0.5, end: 0, duration: 180.ms),
                SizedBox(height: 4.h),
                BlocConsumer<PlantCubit, PlantState>(
                      listener: (context, state) {
                        if (state is PlantError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is PlantLoading) {
                          return Center(
                            child: SpinKitSpinningLines(
                              color: Theme.of(context).primaryColor,
                              size: 30.sp,
                            ),
                          );
                        } else if (state is GetALLPlantSuccess) {
                          final plants = state.plants;
                          if (plants.isEmpty) {
                            return SizedBox(
                              height: 150.h,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("No Plants Found"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              AddPlantManualScreen(),
                                        ),
                                      );
                                    },
                                    child: Text("Add Plant"),
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox(
                            height: 200.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              itemCount: plants.length,
                              itemBuilder: (context, index) {
                                final plant = plants[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: SizedBox(
                                    width: 130.w,
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,

                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                PlantDetailsScreen(
                                                  plant: plant,
                                                ),
                                          ),
                                        );
                                      },
                                      child: PlantCard(
                                        name: plant.name ?? '',
                                        species: plant.species ?? '',
                                        description: '',
                                        imageUrl: plant.imageUrl ?? '',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    )
                    .animate()
                    .fadeIn(delay: 200.ms)
                    .slideY(begin: 0.5, end: 0.2, duration: 200.ms),
                SizedBox(height: 40.h),

                Row(
                      children: [
                        Text(
                          "Today's Tasks",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w900,
                                fontSize: 20.sp,
                              ),
                        ),
                        Spacer(),
                        BadgeContainer(
                          color: AppColors.primary.withOpacity(0.5),
                          content: "4 Tasks",
                          textStyle: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w900,
                                fontSize: 14.sp,
                              ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 220.ms)
                    .slideY(begin: 0.5, end: 0, duration: 220.ms),
                SizedBox(height: 4.h),

                Column(
                      children: [
                        TaskCard(
                          isChecked: false,
                          title: "Rotate Fiddle Leaf Fig",
                          time: "Today, 8 AM",
                          icon: Icons.water_drop_outlined,
                        ),
                        TaskCard(
                          isChecked: false,
                          title: "Rotate Fiddle Leaf Fig",
                          time: "Today, 8 AM",
                          icon: Icons.sunny,
                        ),
                        TaskCard(
                          isChecked: false,
                          title: "Rotate Fiddle Leaf Fig",
                          time: "Today, 8 AM",
                          icon: Icons.place_outlined,
                        ),
                        TaskCard(
                          isChecked: false,
                          title: "Rotate Fiddle Leaf Fig",
                          time: "Today, 8 AM",
                          icon: Icons.bolt,
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 250.ms)
                    .slideY(begin: 0.5, end: 0, duration: 250.ms),
                SizedBox(height: 8.h),

                Text(
                      'Watering Progress',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 270.ms)
                    .slideY(begin: 0.5, end: 0, duration: 270.ms),
                SizedBox(height: 4.h),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  color: Colors.white,
                  child: Row(children: []),
                ),
                SizedBox(height: 8.h),

                TipCard(
                      title: "Daily Tips",
                      imageUrl: 'assets/images/tips.png',
                      color: Colors.yellow,

                      sub:
                          "Morning watering is best for most houseplants — it gives leaves time to dry and prevents fungal diseases.",
                    )
                    .animate()
                    .fadeIn(delay: 300.ms)
                    .slideY(begin: 0.5, end: 0, duration: 300.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class QuickAction {
  final String title;
  final String icon;
  GestureTapCallback? onTap;

  QuickAction({required this.title, required this.icon, this.onTap});
}
