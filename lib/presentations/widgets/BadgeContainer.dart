import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadgeContainer extends StatelessWidget {
  BadgeContainer({
    super.key,
    required this.color,
    required this.content,
    this.textStyle,
  });

  final Color? color;
  final String? content;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color!, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: color!.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: color!.withOpacity(0.1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min, // ✓ مهم
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(content!, style: textStyle, softWrap: true)],
      ),
    );
  }
}
