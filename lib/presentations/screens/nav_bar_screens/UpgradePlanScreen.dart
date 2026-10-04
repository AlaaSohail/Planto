import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../controllers/cubit/subscription_cubit/subscription_cubit.dart';
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
  void initState() {
    super.initState();

    context.read<SubscriptionCubit>().initialize();
  }

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
        child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
          listener: (context, state) {
            if (state is SubscriptionPurchaseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subscription purchased successfully'),
                ),
              );
            }

            if (state is SubscriptionPurchasePending) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment is pending...')),
              );
            }

            if (state is SubscriptionPurchaseCanceled) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchase cancelled')),
              );
            }

            if (state is SubscriptionError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },

          builder: (context, state) {
            if (state is SubscriptionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final cubit = context.read<SubscriptionCubit>();

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.r),

                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Image.asset(
                        "assets/images/pro-member.png",
                        height: 100.h,
                      ),

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

                      // FREE
                      PlantProCard(
                        price: '0',
                        color: Colors.grey,
                        title: localization.free,
                        buttonContent: localization.currentPlan,
                        duration: localization.forever,
                        image: 'assets/images/free.png',
                        showButton: false,
                        feature: [
                          localization.fivePlantIdentificationsPerMonth,
                          localization.basicCareReminders,
                          localization.plantLibraryAccess,
                          localization.communityAccess,
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // WEEKLY
                      if (cubit.weeklyPlan != null)
                        _buildPremiumPlan(
                          context: context,
                          product: cubit.weeklyPlan!,
                          title: 'Premium Weekly',
                          duration: 'per week',
                        ),

                      SizedBox(height: 12.h),

                      // MONTHLY
                      if (cubit.monthlyPlan != null)
                        _buildPremiumPlan(
                          context: context,
                          product: cubit.monthlyPlan!,
                          title: localization.premium,
                          duration: localization.perMonth,
                        ),

                      SizedBox(height: 12.h),

                      // YEARLY
                      if (cubit.yearlyPlan != null)
                        _buildPremiumPlan(
                          context: context,
                          product: cubit.yearlyPlan!,
                          title: 'Premium Yearly',
                          duration: 'per year',
                        ),

                      SizedBox(height: 24.h),

                      TextButton(
                        onPressed: () {
                          context.read<SubscriptionCubit>().restorePurchases();
                        },

                        child: const Text('Restore Purchases'),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPremiumPlan({
    required BuildContext context,
    required ProductDetails product,
    required String title,
    required String duration,
  }) {
    return PlantProCard(
      price: product.price,

      color: const Color(0xfffff454),

      title: title,

      buttonContent: 'Subscribe',

      duration: duration,

      image: 'assets/images/pro.png',

      feature: const [
        'Unlimited AI Identifications',
        'Unlimited AI Plant Doctor',
        'Smart Care Schedules',
        'Advanced Plant Analytics',
        'Priority Support',
        'No Ads',
      ],

      onPressed: () {
        context.read<SubscriptionCubit>().buyPlan(product);
      },
    );
  }
}
