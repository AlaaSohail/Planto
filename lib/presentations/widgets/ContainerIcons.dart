import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class ContainerIcons extends StatelessWidget {
  const ContainerIcons({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0).r,
      child: Container(
        width: 36.w,
        height: 36.w,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          icon,
          width: 20.w,
          height: 20.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
