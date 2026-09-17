import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:plant_care/controllers/core/functions/IsArabic.dart';

import '../themes/app_colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.isChecked,
    required this.title,
    required this.time,
    required this.onChanged,
    this.icon,
  });

  final bool isChecked;
  final String title;
  final String time;
  final IconData? icon;

  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),

      color: isDark(context)
          ? isChecked
          ? const Color(0xffA7E39A).withOpacity(0.7)
          : const Color(0xffA7E39A).withOpacity(0.2)
          : isChecked
          ? Colors.grey.shade300
          : const Color(0xffA7E39A).withOpacity(0.1),

      child: Padding(
        padding: EdgeInsets.all(12.r),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 24.sp,
                color: AppColors.primary,
              ),

              SizedBox(width: 10.w),
            ],

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : null,

                      decorationThickness: 2,

                      fontWeight: isChecked
                          ? FontWeight.w500
                          : FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    time,

                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : null,

                      decorationThickness: 2,

                      fontWeight: isChecked
                          ? FontWeight.w500
                          : FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            MSHCheckbox(
              size: 20.sp,

              value: isChecked,

              colorConfig:
              MSHColorConfig.fromCheckedUncheckedDisabled(
                uncheckedColor: Colors.grey,
                checkedColor:  Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.color!,
              ),

              style: MSHCheckboxStyle.stroke,

              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}