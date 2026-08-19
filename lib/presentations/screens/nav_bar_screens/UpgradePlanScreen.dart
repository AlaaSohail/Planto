import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_theme.dart';

class UpgradePlanScreen extends StatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  State<UpgradePlanScreen> createState() => _UpgradePlanScreenState();
}

class _UpgradePlanScreenState extends State<UpgradePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfff7fbf5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,

        title: Text(
          "Upgrade Plan",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: AppTheme.backButton(context),
        leadingWidth: 55.w,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Image.asset("assets/images/pro-member.png", height: 100.h),

              SizedBox(height: 16.h),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Unlock Your Full ",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: "Garden Potential",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text('Join 50,000+ plant lovers who upgraded to Pro',style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
