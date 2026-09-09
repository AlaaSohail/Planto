import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSocialMedia extends StatelessWidget {
  LoginSocialMedia({super.key, this.imageName, this.onTap});

  String? imageName;
  GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Image.asset(imageName!, width: 42.w, height: 42.h),
    );
  }
}
