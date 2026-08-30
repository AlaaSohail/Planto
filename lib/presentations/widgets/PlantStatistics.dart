import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class PlantStatistics extends StatelessWidget {
  PlantStatistics({super.key, this.title, this.count, this.icon});

  String? title;
  String? count;
  String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon!, width: 36.w, height: 36.h),

          Text(
            count!,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Text(
              title ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
