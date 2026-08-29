import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/themes/app_colors.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    this.location,
    this.fTemperature,
    this.cTemperature,
    this.description,
    this.humidity,
    this.windSpeed,
    this.rain,
    this.icon,
  });

  final String? location;
  final String? fTemperature;
  final String? cTemperature;
  final String? description;
  final String? humidity;
  final double? windSpeed;
  final String? icon;
  final String? rain;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: Colors.green.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.green.withOpacity(0.1)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFd9edfb),
              Color(0xFFe2f2fc),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: 12.0,
            top: 16,
            bottom: 16,
            left: 16,
          ).r,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(icon!, width: 60.w, height: 60.h),

                  SizedBox(width: 12.w),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${cTemperature!}°C\n",
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 30.sp,
                              ),
                        ),
                        TextSpan(
                          text: description!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              Row(
                children: [
                  Image.asset(
                    "assets/images/humidity.png",
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(width: 6.w),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: " ${humidity!}\n",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        TextSpan(
                          text: 'Humidity',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 10.w),
                  Container(
                    width: 0.5.w,
                    height: 36.h,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  SizedBox(width: 10.w),

                  Image.asset(
                    "assets/images/storm.png",
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(width: 6.w),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${(windSpeed! * 4).toStringAsFixed(0)} km/h\n",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,

                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        TextSpan(
                          text: 'Wind',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
