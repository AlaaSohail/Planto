import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plant_care/controllers/models/plant_model.dart';
import 'package:plant_care/presentations/widgets/ModalBottomSheet.dart';

import '../../../controllers/cubit/ai_cubit/ai_cubit.dart';
import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../../controllers/models/ai_model.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/BadgeContainer.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/MainButton.dart';
import '../../widgets/QuickActionsCard.dart';

class PlantDetailsScreen extends StatefulWidget {
  PlantDetailsScreen({super.key, this.plant});

  PlantModel? plant;

  @override
  State<PlantDetailsScreen> createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7fbf5),
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ContainerIcons(icon: 'assets/images/share.png'),
          SizedBox(width: 4.w),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: InkWell(
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  builder: (sheetContext) {
                    return ModalBottomSheet(
                      hintText: 'Are you sure you want to delete this plant?',
                      actionText: "Delete",
                      onPress: () async {
                        // إغلاق BottomSheet
                        Navigator.pop(sheetContext);

                        // استخدم Context الشاشة الأصلية
                        await context.read<PlantCubit>().deletePlant(
                          widget.plant!.plantId!,
                        );

                        if (!mounted) return;

                        Navigator.pop(context);
                      },
                      title: 'Delete Plant',
                    );
                  },
                );
              },
              child: ContainerIcons(icon: 'assets/images/delete.png'),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.plant!.imageUrl!,
              width: double.infinity,
              height: 200.h,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.plant!.name ?? 'Unknown plant',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          Text(
                            widget.plant!.species ?? 'Unknown species',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      BadgeContainer(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        color: AppColors.primary,
                        content:
                            widget.plant!.confidence == null ||
                                widget.plant!.confidence == 0
                            ? 'Not Analyzed'
                            : '${(widget.plant!.confidence! * 100).toStringAsFixed(1)}% Confidence',
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                        backgroundColor: AppColors.primary.withOpacity(0.1),

                        lineWidth: 8.0.w,

                        percent: (widget.plant!.healthScore ?? 0) / 100,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          widget.plant!.healthScore == null ||
                                  widget.plant!.healthScore == 0
                              ? 'N/A'
                              : '${widget.plant!.healthScore!.toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: AppColors.textPrimary),
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
                                text:
                                    '${(widget.plant!.healthStatus?.isNotEmpty ?? false) ? widget.plant!.healthStatus! : 'Not Analyzed'}\n\n',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(color: AppColors.textPrimary),
                              ),

                              TextSpan(
                                text:
                                    (widget.plant!.recommendation?.isNotEmpty ??
                                        false)
                                    ? widget.plant!.recommendation
                                    : 'No recommendation available',
                                style: Theme.of(context).textTheme.bodyMedium
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
                      padding: EdgeInsets.all(0),

                      children: [
                        QuickActionsCard(
                          title: 'Disease',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalBottomSheet(
                                  hintText:
                                      (widget.plant!.disease?.isNotEmpty ??
                                          false)
                                      ? widget.plant!.disease!
                                      : 'No disease analysis available',
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
                                  hintText:
                                      (widget
                                              .plant!
                                              .fertilizerAdvice
                                              ?.isNotEmpty ??
                                          false)
                                      ? widget.plant!.fertilizerAdvice!
                                      : 'No fertilizer advice available',
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
                                  hintText:
                                      (widget
                                              .plant!
                                              .wateringAdvice
                                              ?.isNotEmpty ??
                                          false)
                                      ? widget.plant!.wateringAdvice!
                                      : 'No watering advice available',
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
                                  hintText:
                                      (widget
                                              .plant!
                                              .sunlightAdvice
                                              ?.isNotEmpty ??
                                          false)
                                      ? widget.plant!.sunlightAdvice!
                                      : 'No sunlight advice available',
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
                    content: 'Analyze Plant',
                    onPressed: () async {
                      context.read<PlantCubit>().updatePlantAI(
                        widget.plant!.plantId!,
                        AiAnalysisModel(
                          disease: 'SOON',
                          confidence: 0.99,
                          recommendation: 'SOON',
                          plantName: 'SOON',
                          healthStatus: 'SOON',
                          wateringAdvice: 'SOON',
                          sunlightAdvice: 'SOON',
                          fertilizerAdvice: 'SOON',
                          description: 'SOON',
                          species: 'SOON',
                        ),
                      );
                    },
                    mainAxisSize: MainAxisSize.max,
                    textStyle: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),

                    buttonStyle: AppButtonTheme.theme.style!.copyWith(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>().getPlant();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
