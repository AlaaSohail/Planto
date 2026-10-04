import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';

class LoginSocialMedia extends StatelessWidget {
  LoginSocialMedia({super.key, this.imageName, this.onTap, this.title});

  String? imageName;
  GestureTapCallback? onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Image.asset(imageName!, width: 32.w, height: 32.h),
            Text(title!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
