import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:plant_care/presentations/screens/nav_bar_screens/HomeScreen.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/ProfileScreen.dart';
import 'package:plant_care/presentations/screens/plants_screens/GetPlantScreen.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';

import '../../../l10n/app_localizations.dart';
import 'CommunityScreen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    _widgetOptions = [
      HomeScreen(
        onOpenPlants: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      GetPlantScreen(
        onBackToHome: () {
          setState(() {
            _selectedIndex = 0;
          });
        },
      ),
      CommunityScreen(
            () {
          setState(() {
            _selectedIndex = 0;
          });
        },
      ),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20.r,
              color: AppColors.primary.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 8.h,
            ),
            child: GNav(
              rippleColor: Colors.green[300]!,
              hoverColor: Colors.green[100]!,
              activeColor: Colors.black,
              iconSize: 24.sp,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor:
              AppColors.secondary.withOpacity(0.3),
              tabs: [
                GButton(
                  leading: Image.asset(
                    'assets/images/home.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                    color: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .color!,
                  ),
                  gap: 8,
                  text: localization.home,
                  textStyle:
                  Theme.of(context).textTheme.bodyLarge,
                  icon: Icons.home_rounded,
                ),
                GButton(
                  icon: Icons.nature,
                  text: localization.plants,
                  textStyle:
                  Theme.of(context).textTheme.bodyLarge,
                  leading: Image.asset(
                    'assets/images/leafs.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                    color: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .color!,
                  ),
                ),
                GButton(
                  icon: Icons.camera_alt_outlined,
                  text: localization.community,
                  textStyle:
                  Theme.of(context).textTheme.bodyLarge,
                  leading: Image.asset(
                    'assets/images/world.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                    color: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .color!,
                  ),
                ),
                GButton(
                  icon: Icons.person,
                  text: localization.profile,
                  textStyle:
                  Theme.of(context).textTheme.bodyLarge,
                  leading: Image.asset(
                    'assets/images/user.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                    color: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .color!,
                  ),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}