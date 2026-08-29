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
    this.iconWidth,
    this.iconHeight,
  });

  String? icon;
  String? title;
  String? count;
  double? iconWidth;
  double? iconHeight;

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
        height: 85.h,
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
              padding: EdgeInsetsGeometry.all(8.r),
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
                      ? Image.asset(
                          icon!,
                          width: iconWidth?.w ?? 32.w,
                          height: iconHeight?.h ?? 32.h,
                        )
                      : const SizedBox(),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
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
