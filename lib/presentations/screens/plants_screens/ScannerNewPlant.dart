import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plant_care/controllers/cubit/plant_cubit/plant_cubit.dart';
import 'package:plant_care/controllers/models/ai_model.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';
import 'package:plant_care/presentations/widgets/BadgeContainer.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';
import 'package:plant_care/presentations/widgets/ModalBottomSheet.dart';
import 'package:plant_care/presentations/widgets/PlantCard.dart';
import 'package:plant_care/presentations/widgets/QuickActionsCard.dart';

import '../../../controllers/cubit/ai_cubit/ai_cubit.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_theme.dart';

class ScannerNewPlant extends StatefulWidget {
  ScannerNewPlant({super.key});

  @override
  State<ScannerNewPlant> createState() => _ScannerNewPlantState();
}

class _ScannerNewPlantState extends State<ScannerNewPlant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7fbf5),
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                          'Analyzing Your Plant\nwith AI ...',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is AiAnalyzeSuccess) {
                  final result = state.aiAnalysisModel;

                  return Column(
                    children: [
                      SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: result.imageUrl!,
                          width: double.infinity,
                          height: 250.h,
                          fit: BoxFit.cover,
                        ),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      result.plantName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                          ),
                                    ),
                                    Text(
                                      result.species,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),

                                BadgeContainer(
                                  textStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium,
                                  color: AppColors.primary,
                                  content:
                                      '${result.confidence * 100}% Confidence',
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
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Health Score',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                CircularPercentIndicator(
                                  radius: 40.r,
                                  backgroundColor: AppColors.primary
                                      .withOpacity(0.1),

                                  lineWidth: 8.0.w,

                                  percent: result.healthScore / 100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    '${(result.healthScore).toStringAsFixed(0)}%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: AppColors.textPrimary,
                                        ),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                color: AppColors.textPrimary,
                                              ),
                                        ),

                                        TextSpan(
                                          text: result.recommendation,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: AppColors.textSecondary,
                                                overflow: TextOverflow.ellipsis,
                                              ),
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
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),

                                children: [
                                  QuickActionsCard(
                                    title: 'Disease',
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.disease,
                                            actionText: '',
                                            onPress: () {},
                                            title: 'Disease',
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/virus.png',
                                    color: Colors.white,
                                  ),
                                  QuickActionsCard(
                                    title: 'Fertilize',
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.fertilizerAdvice,
                                            actionText: '',
                                            onPress: () {},
                                            title: 'Fertilize',
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/fertilizer.png',
                                    color: Colors.white,
                                  ),

                                  QuickActionsCard(
                                    title: 'Water',
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.wateringAdvice,
                                            actionText: '',
                                            onPress: () {},
                                            title: 'Watering Instructions',
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/watering.png',
                                    color: Colors.white,
                                  ),
                                  QuickActionsCard(
                                    title: 'Sunlight',
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalBottomSheet(
                                            hintText: result.sunlightAdvice,
                                            actionText: '',
                                            onPress: () {},
                                            title: 'Sunlight Instructions',
                                            child: null,
                                          );
                                        },
                                      );
                                    },
                                    icon: 'assets/images/sunlight.png',
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),

                            MainButton(
                              content: 'Save Plant',
                              onPressed: () async {
                                await context.read<PlantCubit>().addPlant(
                                  result.plantName,
                                  result.species,
                                  context.read<AiCubit>().analyzeImage,
                                  result.description,
                                );
                              },
                              mainAxisSize: MainAxisSize.max,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),

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

  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
