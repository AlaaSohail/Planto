import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../l10n/app_localizations.dart';

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
import 'LanguageScreen.dart';
import 'NotificationScreen.dart';
import 'PasswordChangeScreen.dart';
import 'SettingScreen.dart';
import 'ThemeModeScreen.dart' show ThemeModeScreen;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

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
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              centerTitle: true,
              title: AppTheme.plantCareAILogo(context),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.w),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const EditProfileDetailsScreen(),
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
                    child: SpinKitSpinningLines(
                      color: Theme.of(context).textTheme.headlineSmall!.color!,
                      size: 30.sp,
                    ),
                  )
                : state is UserSuccess
                ? SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    state.user.image ??
                                    'https://res.cloudinary.com/n4qtd6co/image/upload/v1788421140/farmer_hw0ugv.png',
                                width: 100.r,
                                height: 100.r,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Container(
                                    color: AppColors.primary.withOpacity(0.1),
                                    child: Center(
                                      child: SpinKitSpinningLines(
                                        color: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall!.color!,
                                        size: 30.sp,
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
                              content: "  ${localization.proMember}  ",
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
                                    builder: (_) => const UpgradePlanScreen(),
                                  ),
                                );
                              },
                              child: TipCard(
                                title: localization.plantoPro,
                                image: Image.asset(
                                  'assets/images/plantBot.png',
                                  width: 60.w,
                                  height: 60.h,
                                ),
                                color: AppColors.primary,
                                sub: localization
                                    .unlimitedAIScansAdvancedAnalytics,
                              ),
                            ),

                            SizedBox(height: 16.h),

                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                localization.account,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),

                            SizedBox(height: 16.h),

                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffA7E39A).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 0.5.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ProfileCard(
                                    icon: 'assets/images/notification.png',
                                    title: localization.notifications,
                                    page: const NotificationScreen(),
                                  ),

                                  Divider(
                                    height: 0.5.h,
                                    thickness: 0.5,
                                    color: Colors.grey.shade300,
                                  ),

                                  ProfileCard(
                                    icon: 'assets/images/dark.png',
                                    title: localization.darkMode,
                                    page: ThemeModeScreen(),
                                  ),

                                  Divider(
                                    height: 0.5.h,
                                    thickness: 0.5,
                                    color: Colors.grey.shade300,
                                  ),

                                  ProfileCard(
                                    icon: 'assets/images/internet.png',
                                    title: localization.language,
                                    page: const LanguageScreen(),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16.h),

                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                localization.app,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),

                            SizedBox(height: 16.h),

                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffA7E39A).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 0.5.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ProfileCard(
                                    icon: 'assets/images/premium.png',
                                    title: localization.premiumPlan,
                                    page: const UpgradePlanScreen(),
                                  ),

                                  Divider(
                                    height: 0.5.h,
                                    thickness: 0.5,
                                    color: Colors.grey.shade300,
                                  ),
                                  ProfileCard(
                                    icon: 'assets/images/privacy-policy.png',
                                    title: localization.password,
                                    page: const PasswordChangeScreen(),
                                  ),
                                  Divider(
                                    height: 0.5.h,
                                    thickness: 0.5,
                                    color: Colors.grey.shade300,
                                  ),
                                  ProfileCard(
                                    icon: 'assets/images/settings.png',
                                    title: localization.preferences,
                                    page: const SettingScreen(),
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
                                    builder: (_) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.redAccent,
                              ),
                              content: localization.signOut,
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
}
