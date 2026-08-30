import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/controllers/cubit/user_cubit/user_cubit.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/UpgradePlanScreen.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';
import 'package:plant_care/presentations/widgets/TipCard.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/BadgeContainer.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/ProfileCard.dart';
import '../auth_screens/LoginScreen.dart';
import 'EditProfileDetailsScreen.dart';
import 'NotificationScreen.dart';
import 'PasswordChangeScreen.dart';
import 'SettingScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xfff7fbf5),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Text(''),
              leadingWidth: 16.w,
              foregroundColor: Colors.transparent,
              title: AppTheme.plantCareAILogo(),

              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,

                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => EditProfileDetailsScreen(),
                        ),
                      );
                    },

                    child: ContainerIcons(icon: 'assets/images/edit.png'),
                  ),
                ),
              ],
            ),
            body: state is UserLoading
                ? Center(
                    child: Center(
                      child: SpinKitSpinningLines(
                        color: Theme.of(context).primaryColor,
                        size: 30.sp,
                      ),
                    ),
                  )
                : state is UserSuccess
                ? SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0.r),
                        child: Column(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    state.user.image ??
                                    'assets/images/farmer.png',
                                width: 100.r,
                                height: 100.r,
                                fit: BoxFit.cover,

                                placeholder: (context, url) {
                                  return Container(
                                    color: AppColors.primary.withOpacity(0.1),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  );
                                },

                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: AppColors.primary.withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      size: 45.sp,
                                      color: AppColors.primary,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.user.name,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(height: 8.h),
                            BadgeContainer(
                              color: Colors.yellowAccent.withOpacity(0.3),
                              content: "  Pro Member  ",
                              textStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.sp,
                                  ),
                            ),
                            SizedBox(height: 12.h),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => UpgradePlanScreen(),
                                  ),
                                );
                              },
                              child: TipCard(
                                title: "Planto Pro",
                                image: Image.asset(
                                  'assets/images/plantBot.png',
                                  width: 60.w,
                                  height: 60.h,
                                ),
                                color: AppColors.primary,
                                sub: "Unlimited AI scans · Advanced analytics",
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "ACCOUNT",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.sp,
                                    ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ProfileCard(
                                    icon: 'assets/images/notification.png',
                                    title: 'Notifications',
                                    page: NotificationScreen(),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  ProfileCard(
                                    icon: 'assets/images/privacy-policy.png',
                                    title: 'Password',
                                    page: PasswordChangeScreen(),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  ProfileCard(
                                    icon: 'assets/images/internet.png',
                                    title: 'Language',
                                    page: SettingScreen(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "APP",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.sp,
                                    ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              width: double.infinity,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ProfileCard(
                                    icon: 'assets/images/premium.png',
                                    title: 'Premium Plan',
                                    page: NotificationScreen(),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  ProfileCard(
                                    icon: 'assets/images/leafs.png',
                                    title: 'Plant Journal',
                                    page: NotificationScreen(),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  ProfileCard(
                                    icon: 'assets/images/settings.png',
                                    title: 'Preferences',
                                    page: SettingScreen(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),

                            MainButton(
                              mainAxisSize: MainAxisSize.max,
                              onPressed: () async {
                                await context.read<UserCubit>().logout();
                                if (!context.mounted) return;
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              icon: Icon(Icons.logout, color: Colors.redAccent),
                              content: "Sign Out",
                              buttonStyle: AppButtonTheme.themeTertiary.style,

                              textStyle: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserProfile();
  }
}
