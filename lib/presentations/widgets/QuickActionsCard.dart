import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    super.key,
    this.icon,
    this.title,
    this.color,
    this.onTap,
    this.count,
    this.iconWidth,
    this.iconHeight,
  });

  final String? icon;
  final String? title;
  final String? count;

  final double? iconWidth;
  final double? iconHeight;

  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: 92.w,
        height: 92.h,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.all(6.r),
          color: color ?? AppColors.secondary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: AppColors.primary, width: 0.3.w),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (count != null)
                  Text(
                    count!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                else if (icon != null)
                  Image.asset(
                    icon!,
                    width: iconWidth?.w ?? 32.w,
                    height: iconHeight?.h ?? 32.h,
                    fit: BoxFit.contain,
                  ),

                SizedBox(height: 4.h),

                Flexible(
                  child: Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
