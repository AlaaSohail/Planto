import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/models/plant_model.dart';

import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';

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

                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0).r,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 3.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Delete Plant",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Are you sure you want to delete this plant?",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 16.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context); // إغلاق Dialog

                                  await context.read<PlantCubit>().deletePlant(
                                    widget.plant!.plantId!,
                                  );

                                  if (!mounted) return;

                                  Navigator.pop(
                                    context,
                                  ); // الرجوع من Details إلى Plants
                                },
                                child: Text(
                                  "Delete",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: AppColors.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.plant!.imageUrl!,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  left: 16.w,
                  child: Text(
                    widget.plant!.name!,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 16.w,
                  child: Text(
                    widget.plant!.species!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 16.r, left: 16.r),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        color: AppColors.secondary.withOpacity(0.3),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(height: 8.h),
                                Text(
                                  "About this plant",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  widget.plant!.description!,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        wordSpacing: 0.5,
                                        letterSpacing: 1,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
