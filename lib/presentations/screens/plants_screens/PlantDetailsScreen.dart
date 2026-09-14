import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:plant_care/controllers/models/plant_model.dart';
import 'package:plant_care/presentations/widgets/ModalBottomSheet.dart';

import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../../controllers/models/ai_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/BadgeContainer.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/MainButton.dart';
import '../../widgets/QuickActionsCard.dart';

class PlantDetailsScreen extends StatefulWidget {
  const PlantDetailsScreen({
    super.key,
    this.plant,
  });

  final PlantModel? plant;

  @override
  State<PlantDetailsScreen> createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>().getPlant();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,        titleSpacing: 0,

        actions: [
          ContainerIcons(
            icon: 'assets/images/share.png',
          ),

          SizedBox(width: 4.w),

          Padding(
            padding: EdgeInsetsDirectional.only(end: 16.w),
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
                      hintText:
                      localization.areYouSureDeletePlant,
                      actionText: localization.delete,
                      onPress: () async {
                        Navigator.pop(sheetContext);

                        await context
                            .read<PlantCubit>()
                            .deletePlant(
                          widget.plant!.plantId!,
                        );

                        if (!mounted) return;

                        Navigator.pop(context);
                      },
                      title: localization.deletePlant,
                    );
                  },
                );
              },
              child: ContainerIcons(
                icon: 'assets/images/delete.png',
              ),
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
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.plant!.name?.isNotEmpty == true
                                  ? widget.plant!.name!
                                  : localization.unknownPlant,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall,
                            ),

                            Text(
                              widget.plant!.species?.isNotEmpty == true
                                  ? widget.plant!.species!
                                  : localization.unknownSpecies,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 8.w),

                      BadgeContainer(
                        textStyle:
                        Theme.of(context).textTheme.bodyMedium,
                        color: AppColors.primary,
                        content:
                        widget.plant!.confidence == null ||
                            widget.plant!.confidence == 0
                            ? localization.notAnalyzed
                            : localization.confidencePercent(
                          (widget.plant!.confidence! * 100)
                              .toStringAsFixed(1),
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
                        backgroundColor:
                        AppColors.primary.withOpacity(0.1),
                        lineWidth: 8.w,
                        percent:
                        (widget.plant!.healthScore ?? 0) / 100,
                        circularStrokeCap:
                        CircularStrokeCap.round,
                        center: Text(
                          widget.plant!.healthScore == null ||
                              widget.plant!.healthScore == 0
                              ? localization.notAvailable
                              : '${widget.plant!.healthScore!.toStringAsFixed(0)}%',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall,
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
                                '${(widget.plant!.healthStatus?.isNotEmpty ?? false) ? widget.plant!.healthStatus! : localization.notAnalyzed}\n\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              ),
                              TextSpan(
                                text: (widget
                                    .plant!
                                    .recommendation
                                    ?.isNotEmpty ??
                                    false)
                                    ? widget.plant!.recommendation
                                    : localization
                                    .noRecommendationAvailable,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  overflow:
                                  TextOverflow.ellipsis,
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
                      padding: EdgeInsets.zero,
                      children: [
                        QuickActionsCard(
                          title: localization.disease,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalBottomSheet(
                                  hintText:
                                  (widget.plant!.disease
                                      ?.isNotEmpty ??
                                      false)
                                      ? widget.plant!.disease!
                                      : localization
                                      .noDiseaseAnalysisAvailable,
                                  actionText: '',
                                  onPress: () {},
                                  title: localization.disease,
                                  child: null,
                                );
                              },
                            );
                          },
                          icon: 'assets/images/virus.png',
                          color: Colors.white,
                        ),

                        QuickActionsCard(
                          title: localization.fertilize,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalBottomSheet(
                                  hintText: (widget
                                      .plant!
                                      .fertilizerAdvice
                                      ?.isNotEmpty ??
                                      false)
                                      ? widget
                                      .plant!
                                      .fertilizerAdvice!
                                      : localization
                                      .noFertilizerAdviceAvailable,
                                  actionText: '',
                                  onPress: () {},
                                  title: localization.fertilize,
                                  child: null,
                                );
                              },
                            );
                          },
                          icon: 'assets/images/fertilizer.png',
                          color: Colors.white,
                        ),

                        QuickActionsCard(
                          title: localization.water,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalBottomSheet(
                                  hintText: (widget
                                      .plant!
                                      .wateringAdvice
                                      ?.isNotEmpty ??
                                      false)
                                      ? widget
                                      .plant!
                                      .wateringAdvice!
                                      : localization
                                      .noWateringAdviceAvailable,
                                  actionText: '',
                                  onPress: () {},
                                  title:
                                  localization.wateringInstructions,
                                  child: null,
                                );
                              },
                            );
                          },
                          icon: 'assets/images/watering.png',
                          color: Colors.white,
                        ),

                        QuickActionsCard(
                          title: localization.sunlight,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalBottomSheet(
                                  hintText: (widget
                                      .plant!
                                      .sunlightAdvice
                                      ?.isNotEmpty ??
                                      false)
                                      ? widget
                                      .plant!
                                      .sunlightAdvice!
                                      : localization
                                      .noSunlightAdviceAvailable,
                                  actionText: '',
                                  onPress: () {},
                                  title:
                                  localization.sunlightInstructions,
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
                    content: localization.analyzePlant,
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
                    textStyle:
                    Theme.of(context).textTheme.headlineSmall,
                    buttonStyle:
                    AppButtonTheme.theme.style!.copyWith(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}