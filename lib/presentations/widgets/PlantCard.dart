import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({
    required this.name,
    required this.species,
    this.description,
    super.key,
    this.imageUrl,
    this.percent = 0,
  });

  final String? name;
  final String? species;
  final String? description;
  final String? imageUrl;
  final double? percent;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: AppColors.secondary.withOpacity(0.1),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100.h,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl ?? '',
                  placeholder: (context, url) => SpinKitSpinningLines(
                    color: Theme.of(context).primaryColor,
                    size: 30.sp,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name ?? 'Unknown Plant',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),

                  Text(
                    species ?? 'Unknown species',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  LinearPercentIndicator(
                    percent: percent != null || percent != 0
                        ? percent! / 100
                        : 0.0,
                    lineHeight: 4.h,
                    barRadius: Radius.circular(8).r,
                    progressColor: Colors.green,
                    animationDuration: 1000,
                    padding: EdgeInsets.only(right: 32.w),

                    animation: true,
                    backgroundColor: Colors.green.withOpacity(0.2),
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
