import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class QuickActionsCard extends StatelessWidget {
  QuickActionsCard({
    super.key,
    this.icon,
    this.title,
    this.color,
    this.onTap,
    this.count,
  });

  String? icon;
  String? title;
  String? count;

  Color? color;
  GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: SizedBox(
        width: 90.w,
        height: 80.h,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: AppColors.primary, width: 0.3.w),
          ),
          margin: EdgeInsets.all(6.r),
          color: color,
          child: Center(
            child: Padding(
              padding: EdgeInsetsGeometry.all(10.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  count != null
                      ? Text(
                          count!,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: AppColors.textPrimary),
                        )
                      : icon != null
                      ? Image.asset(icon!, width: 36.w, height: 36.h)
                      : const SizedBox(),
                  SizedBox(height: 8.h),
                  Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
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
