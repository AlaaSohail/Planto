import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../themes/app_button_theme.dart';

class PlantProCard extends StatelessWidget {
  const PlantProCard({
    super.key,
    required this.price,
    required this.title,
    required this.duration,
    required this.buttonContent,
    required this.feature,
    required this.image,
    required this.color,
    this.onPressed,
    this.showButton = true,
  });

  final String price;
  final String duration;
  final List<String> feature;
  final String buttonContent;
  final String title;
  final String image;
  final Color color;

  final VoidCallback? onPressed;

  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.2),
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  width: 36.w,
                  height: 36.h,
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$title\n',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        TextSpan(
                          text: price,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        TextSpan(
                          text: ' /$duration',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: feature.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final action = feature[index];

                return Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text(
                    action,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              },
            ),

            if (showButton) ...[
              SizedBox(height: 16.h),

              MainButton(
                buttonStyle:
                AppButtonTheme.themeSecondary.style!.copyWith(),
                content: buttonContent,
                textStyle:
                Theme.of(context).textTheme.headlineSmall,
                onPressed: onPressed,
                mainAxisSize: MainAxisSize.min,
              ),
            ],
          ],
        ),
      ),
    );
  }
}