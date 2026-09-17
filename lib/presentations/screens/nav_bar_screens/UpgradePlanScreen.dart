import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../l10n/app_localizations.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/PlantProCard.dart';

class UpgradePlanScreen extends StatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  State<UpgradePlanScreen> createState() => _UpgradePlanScreenState();
}

class _UpgradePlanScreenState extends State<UpgradePlanScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,

        title: Text(
          localization.upgradePlan,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: AppTheme.backButton(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/pro-member.png", height: 100.h),

                  SizedBox(height: 16.h),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: localization.unlockYourFull,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        TextSpan(
                          text: localization.gardenPotential,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    localization.joinPlantLoversPro,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  SizedBox(height: 16.h),

                  PlantProCard(
                    price: 0,
                    color: Colors.grey,
                    title: localization.free,
                    buttonContent: localization.currentPlan,
                    duration: localization.forever,
                    image: 'assets/images/free.png',
                    feature: [
                      localization.fivePlantIdentificationsPerMonth,
                      localization.basicCareReminders,
                      localization.plantLibraryAccess,
                      localization.communityAccess,
                    ],
                  ),

                  SizedBox(height: 8.h),

                  PlantProCard(
                    price: 4.99,
                    color: const Color(0xfffff454),
                    title: localization.premium,
                    buttonContent: localization.startFreeTrial,
                    duration: localization.perMonth,
                    image: 'assets/images/pro.png',
                    feature: [
                      localization.unlimitedAIIdentifications,
                      localization.aiPlantDoctorUnlimited,
                      localization.smartCareSchedules,
                      localization.advancedPlantAnalytics,
                      localization.prioritySupport,
                      localization.noAds,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
