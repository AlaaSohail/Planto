import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/widgets/ContainerIcons.dart';

import '../themes/app_colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.page,
  });

  final String? icon;
  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ListTile(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,

        leading: ContainerIcons(icon: icon!),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),

        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => page),
          );
        },
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
          size: 14.sp,
        ),
      ),
    );
  }
}
