import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../l10n/app_localizations.dart';

import 'package:plant_care/presentations/themes/app_colors.dart';

import '../../../controllers/cache/cache_helper.dart';
import '../../../controllers/services/service_locator.dart';
import '../../themes/app_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool value =
      getIt<CacheHelper>().getData(key: 'notification') ?? false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        title: AppTheme.plantCareAILogo(context),
        leadingWidth: 32.w,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AppTheme.backButton(context),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Container(
              height: 56.h,
              width: double.infinity,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Text(
                    localization.pushNotifications,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const Spacer(),

                  Switch(
                    value: value,
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue;

                        getIt<CacheHelper>().put(
                          key: 'notification',
                          value: value,
                        );
                      });

                      if (value) {
                        debugPrint("Switch Button is ON");
                      } else {
                        debugPrint("Switch Button is OFF");
                      }
                    },
                    activeColor: const Color(0xffA7E39A),
                    activeTrackColor:
                    const Color(0xffA7E39A).withOpacity(0.5),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor:
                    Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}