import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../themes/app_colors.dart';

class TaskCard extends StatefulWidget {
  TaskCard({
    super.key,
    required this.isChecked,
    required this.title,
    required this.time,
    this.icon,
  });

  bool? isChecked;
  String? title;
  String? time;
  IconData? icon;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      color: widget.isChecked! ? Colors.grey.shade100 : Colors.white,
      child: Padding(
        padding:  EdgeInsets.all(12.0.r),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(widget.icon, color: Colors.white),
            ),
            SizedBox(width: 16.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    decoration: widget.isChecked!
                        ? TextDecoration.lineThrough
                        : null,
                    decorationThickness: 2,
                    fontWeight: widget.isChecked!
                        ? FontWeight.w500
                        : FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.time!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: widget.isChecked!
                        ? TextDecoration.lineThrough
                        : null,
                    decorationThickness: 2,
                    fontWeight: widget.isChecked!
                        ? FontWeight.w500
                        : FontWeight.w700,
                  ),
                ),
              ],
            ),
            Spacer(),
            MSHCheckbox(
              size: 20.sp,
              value: widget.isChecked!,
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                uncheckedColor: Colors.grey,
                checkedColor: AppColors.textPrimary,
              ),
              style: MSHCheckboxStyle.stroke,
              onChanged: (selected) {
                setState(() {
                  widget.isChecked = selected;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
