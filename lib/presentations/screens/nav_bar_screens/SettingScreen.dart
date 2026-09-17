import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/cache/cache_helper.dart';
import '../../../controllers/services/service_locator.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ProfileCard.dart';
import 'EditProfileDetailsScreen.dart';
import 'LanguageScreen.dart';
import 'NotificationScreen.dart';
import 'PasswordChangeScreen.dart';
import 'SupportScreen.dart';
import 'ThemeModeScreen.dart';
import 'UpgradePlanScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        titleSpacing: 0,
        title: Text(
          localization.preferences,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: AppTheme.backButton(context),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              children: [
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
                        icon: 'assets/images/user.png',
                        title: localization.personalInfo,

                        page: EditProfileDetailsScreen(),
                      ),

                      Divider(
                        height: 0.5.h,
                        thickness: 0.5,
                        color: Colors.grey.shade300,
                      ),

                      ProfileCard(
                        icon: 'assets/images/privacy-policy.png',
                        title: localization.password,
                        page: PasswordChangeScreen(),
                      ),

                      Divider(
                        height: 0.5.h,
                        thickness: 0.5,
                        color: Colors.grey.shade300,
                      ),

                      ProfileCard(
                        icon: 'assets/images/premium.png',
                        title: localization.premiumPlan,
                        page: const UpgradePlanScreen(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    localization.preferences.toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(letterSpacing: 2.sp),
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
                        title: localization.appearance,
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
                    localization.support.toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(letterSpacing: 2.sp),
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
                        title: localization.registerPrivacyPolicy,
                        page: SupportScreen(
                          title: localization.privacyPolicy,
                          privacy: [
                            {
                              'title': localization.privacyLastUpdate,
                              'content': localization.privacyLastUpdateContent,
                            },
                            {
                              'title': localization.infoWeCollect,
                              'content': localization.infoWeCollectContent,
                            },
                            {
                              'title': localization.howToUseTheInformation,
                              'content':
                                  localization.howToUseTheInformationContent,
                            },
                            {
                              'title': localization.picturesAndPlantAnalysis,
                              'content':
                                  localization.picturesAndPlantAnalysisContent,
                            },
                            {
                              'title': localization.geographicLocation,
                              'content': localization.geographicLocationContent,
                            },
                            {
                              'title': localization.thirdPartyServices,
                              'content': localization.thirdPartyServicesContent,
                            },
                            {
                              'title': localization.ads,
                              'content': localization.adsContent,
                            },
                            {
                              'title': localization.subscriptionsAndPayments,
                              'content':
                                  localization.subscriptionsAndPaymentsContent,
                            },
                            {
                              'title': localization.dataProtection,
                              'content': localization.dataProtectionContent,
                            },
                            {
                              'title': localization.dataRetention,
                              'content': localization.dataRetentionContent,
                            },
                            {
                              'title': localization.deleteAccountAndData,
                              'content':
                                  localization.deleteAccountAndDataContent,
                            },
                            {
                              'title': localization.appPermissions,
                              'content': localization.appPermissionsContent,
                            },
                            {
                              'title': localization.privacyPolicyChanges,
                              'content':
                                  localization.privacyPolicyChangesContent,
                            },
                            {
                              'title': localization.contactUsPrivacy,
                              'content': localization.contactUsPrivacyContent,
                            },
                          ],
                        ),
                      ),

                      Divider(
                        height: 0.5.h,
                        thickness: 0.5,
                        color: Colors.grey.shade300,
                      ),
                      ProfileCard(
                        icon: 'assets/images/dark.png',
                        title: localization.helpCenter,
                        page: SupportScreen(
                          title: localization.helpCenter,
                          privacy: [
                            {
                              'title': localization.infoWeCollect,
                              'content': localization.infoWeCollectContent,
                            },
                            {
                              'title': localization.howToUseTheInformation,
                              'content':
                                  localization.howToUseTheInformationContent,
                            },
                            {
                              'title': localization.picturesAndPlantAnalysis,
                              'content':
                                  localization.picturesAndPlantAnalysisContent,
                            },
                            {
                              'title': localization.geographicLocation,
                              'content': localization.geographicLocationContent,
                            },
                            {
                              'title': localization.thirdPartyServices,
                              'content': localization.thirdPartyServicesContent,
                            },
                            {
                              'title': localization.ads,
                              'content': localization.adsContent,
                            },
                            {
                              'title': localization.subscriptionsAndPayments,
                              'content':
                                  localization.subscriptionsAndPaymentsContent,
                            },
                            {
                              'title': localization.dataProtection,
                              'content': localization.dataProtectionContent,
                            },
                            {
                              'title': localization.dataRetention,
                              'content': localization.dataRetentionContent,
                            },
                            {
                              'title': localization.deleteAccountAndData,
                              'content':
                                  localization.deleteAccountAndDataContent,
                            },
                            {
                              'title': localization.appPermissions,
                              'content': localization.appPermissionsContent,
                            },
                            {
                              'title': localization.privacyPolicyChanges,
                              'content':
                                  localization.privacyPolicyChangesContent,
                            },
                            {
                              'title': localization.contactUsPrivacy,
                              'content': localization.contactUsPrivacyContent,
                            },
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.5.h,
                        thickness: 0.5,
                        color: Colors.grey.shade300,
                      ),
                      ProfileCard(
                        icon: 'assets/images/internet.png',
                        title: localization.contactUs,
                        page: SupportScreen(
                          title: localization.contactUs,
                          privacy: [
                            {
                              'title': localization.aboutAppWhatIs,
                              'content': localization.aboutAppWhatIsContent,
                            },
                            {
                              'title': localization.aboutAppFeatures,
                              'content': localization.aboutAppFeaturesContent,
                            },
                            {
                              'title': localization.aboutAppAI,
                              'content': localization.aboutAppAIContent,
                            },
                            {
                              'title': localization.aboutAppMission,
                              'content': localization.aboutAppMissionContent,
                            },
                            {
                              'title': localization.aboutAppVersion,
                              'content': localization.aboutAppVersionContent,
                            },
                            {
                              'title': localization.aboutAppContact,
                              'content': localization.aboutAppContactContent,
                            },
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text("Version 1.0.0"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
