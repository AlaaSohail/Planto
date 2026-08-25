import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({
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

  String? location;
  String? fTemperature;
  String? cTemperature;
  String? description;
  String? humidity;
  double? windSpeed;
  String? icon;
  String? rain;

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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFF1F1C9), Color(0xFFe7f2e7), Color(0xFFe7f2e7)],
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
                  Text(icon!, style: Theme.of(context).textTheme.bodyLarge),

                  SizedBox(width: 8.w),
                  Text(
                    location!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              Text(
                "${cTemperature!}°",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30.sp,
                ),
              ),

              SizedBox(height: 8.h),
              Text(description!, style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Image.asset("assets/images/humidity.png", width: 16.w),
                  Text(
                    ": ${humidity!}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Image.asset("assets/images/wind.png", width: 16.w),
                  Text(
                    ": ${(windSpeed! * 4).toStringAsFixed(0)} km/h",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,

                      fontWeight: FontWeight.w900,
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
