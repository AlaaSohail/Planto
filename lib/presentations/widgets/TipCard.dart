import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class TipCard extends StatelessWidget {
  TipCard({
    super.key,
    required this.sub,
    this.title,
    this.imageUrl,
    this.color,
  });

  String? sub;
  String? title;
  String? imageUrl;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
        side: BorderSide(color: color ?? Colors.grey, width: 0.5.w),
      ),

      color: color!.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(imageUrl!, width: 42.w, height: 42.h),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    sub!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
