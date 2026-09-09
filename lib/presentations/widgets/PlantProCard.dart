import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/cubit/payment_cubit/payment_cubit.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../screens/auth_screens/LoginScreen.dart';
import '../themes/app_button_theme.dart';
import '../themes/app_colors.dart';
import 'QuickActionsCard.dart';

class PlantProCard extends StatelessWidget {
  PlantProCard({
    super.key,
    this.price,
    this.title,
    this.duration,
    this.buttonContent,
    this.feature,
    this.image,
    this.color,
  });

  double? price;
  String? duration;
  List<String>? feature;
  String? buttonContent;
  String? title;
  String? image;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color!.withOpacity(0.2),
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(12.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(image!, width: 36.w, height: 36.h),
                SizedBox(width: 12.w),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${title}\n",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              height: 2.h,
                            ),
                      ),
                      TextSpan(
                        text: "\$${price.toString()}",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.sp,
                            ),
                      ),
                      TextSpan(
                        text: '\\${duration}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: feature!.length,
                itemBuilder: (context, index) {
                  final action = feature![index];

                  return Text(
                    action,
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                },
              ),
            ),
            MainButton(
              buttonStyle: AppButtonTheme.themeSecondary.style!.copyWith(),
              content: buttonContent,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: AppColors.textPrimary),
              onPressed: () async {
                await context.read<PaymentCubit>().makePayment(10, 'usd');
              },
              mainAxisSize: MainAxisSize.min,
            ),
          ],
        ),
      ),
    );
  }
}
