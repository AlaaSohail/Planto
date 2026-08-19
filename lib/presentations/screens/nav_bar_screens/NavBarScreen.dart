import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/HomeScreen.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/ProfileScreen.dart';
import 'package:plant_care/presentations/screens/plants_screens/GetPlantScreen.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';

import '../ai_chat_screen/AiChatScreen.dart';
import 'ScannerScreen.dart';

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
      ScannerScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20.r,
              color: AppColors.primary.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.h),
            child: GNav(
              rippleColor: Colors.green[300]!,
              hoverColor: Colors.green[100]!,
              gap: 8,

              activeColor: Colors.black,
              iconSize: 24.sp,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.green[100]!,

              color: Colors.black,
              tabs: [
                GButton(
                  leading: Image.asset(
                    'assets/images/home.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                  text: 'Home',
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                  icon: Icons.home_rounded,
                ),
                GButton(
                  icon: Icons.nature,
                  text: 'Plants',
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                  leading: Image.asset(
                    'assets/images/leafs.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                ),
                GButton(
                  icon: Icons.camera_alt_outlined,
                  text: 'Scan',
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                  leading: Image.asset(
                    'assets/images/camera.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                  leading: Image.asset(
                    'assets/images/user.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
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

  @override
  void dispose() {
    super.dispose();
  }
}
