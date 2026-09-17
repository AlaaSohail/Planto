import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:plant_care/controllers/cubit/plant_cubit/plant_cubit.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';
import 'package:plant_care/presentations/widgets/BadgeContainer.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';
import 'package:plant_care/presentations/widgets/ModalBottomSheet.dart';
import 'package:plant_care/presentations/widgets/QuickActionsCard.dart';

import '../../../controllers/cubit/ai_cubit/ai_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_theme.dart';

class ScannerNewPlant extends StatefulWidget {
  const ScannerNewPlant({super.key});

  @override
  State<ScannerNewPlant> createState() => _ScannerNewPlantState();
}

class _ScannerNewPlantState extends State<ScannerNewPlant> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,        titleSpacing: 0,

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AiCubit, AiState>(
              builder: (context, state) {
                if (state is AiLoading) {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/lottie/Plant_Scanning.json",
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),

                        Text(
                          localization.analyzingPlantWithAI,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  );
                }

                if (state is AiAnalyzeSuccess) {
                  final result = state.aiAnalysisModel;
                  final image = context.read<AiCubit>().analyzeImage;

                  if (image == null) {
                    return const SizedBox();
                  }

                  return Column(
                    children: [
                      Image.file(
                        File(image.path),
                        width: double.infinity,
                        height: 250.h,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        result.plantName,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                      ),

                                      Text(
                                        result.species,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 8.w),

                                BadgeContainer(
                                  textStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium,
                                  color: AppColors.primary,
                                  content: localization.confidencePercent(
                                    (result.confidence * 100).toStringAsFixed(
                                      1,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            Divider(
                              color: Colors.grey.withOpacity(0.3),
                              thickness: 1.h,
                              height: 1.h,
                              indent: 16.w,
                              endIndent: 16.w,
                            ),

                            SizedBox(height: 16.h),

                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                localization.healthScore,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularPercentIndicator(
                                  radius: 40.r,
                                  backgroundColor: AppColors.primary
                                      .withOpacity(0.1),
                                  lineWidth: 8.w,
                                  percent: result.healthScore / 100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    '${result.healthScore.toStringAsFixed(0)}%',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                                  progressColor: AppColors.secondary,
                                  animation: true,
                                  animationDuration: 1000,
                                ),

                                SizedBox(width: 32.w),

                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${result.healthStatus}\n\n',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineSmall,
                                        ),
                                        TextSpan(
                                          text: result.recommendation,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            Divider(
                              color: Colors.grey.withOpacity(0.3),
                              thickness: 1.h,
                              height: 1.h,
                              endIndent: 16.w,
                            ),

                            SizedBox(height: 12.h),

                            SizedBox(
                              height: 90.h,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                children: [
                                  QuickActionsCard(
                                    title: localization.disease,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.disease,
                                            actionText: '',
                                            onPress: () {},
                                            title: localization.disease,
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/virus.png',
                                  ),

                                  QuickActionsCard(
                                    title: localization.fertilize,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.fertilizerAdvice,
                                            actionText: '',
                                            onPress: () {},
                                            title: localization.fertilize,
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/fertilizer.png',
                                  ),

                                  QuickActionsCard(
                                    title: localization.water,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.wateringAdvice,
                                            actionText: '',
                                            onPress: () {},
                                            title: localization
                                                .wateringInstructions,
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/watering.png',
                                  ),

                                  QuickActionsCard(
                                    title: localization.sunlight,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.sunlightAdvice,
                                            actionText: '',
                                            onPress: () {},
                                            title: localization
                                                .sunlightInstructions,
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/sunlight.png',
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 12.h),

                            MainButton(
                              content: localization.savePlant,
                              onPressed: () async {
                                await context.read<PlantCubit>().addPlant(
                                  result.plantName,
                                  result.species,
                                  context.read<AiCubit>().analyzeImage,
                                  result.description,
                                  result.healthStatus,
                                  result.healthScore,
                                  result.wateringAdvice,
                                  result.sunlightAdvice,
                                  result.fertilizerAdvice,
                                  result.disease,
                                  result.confidence,
                                  result.recommendation,
                                );
                              },
                              mainAxisSize: MainAxisSize.max,
                              textStyle: Theme.of(
                                context,
                              ).textTheme.headlineSmall,
                              buttonStyle: AppButtonTheme.theme.style!
                                  .copyWith(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                if (state is AiAnalyzeError) {
                  return Text(state.message);
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
