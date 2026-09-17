import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';
import '../../themes/app_theme.dart';

class SupportScreen extends StatefulWidget {
  SupportScreen({
    super.key,
    this.title,
    this.content,
    this.subTitle,
    this.privacy,
  });

  String? title;
  String? subTitle;
  String? content;

  List? privacy;

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        title: Text(
          widget.title ?? localization.support,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,

        leading: AppTheme.backButton(context),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0).r,
          child: Column(
            children: [
              // Text(widget.subTitle ?? ''),
              // SizedBox(height: 16.h),
              // Text(widget.content ?? ''),
              SizedBox(height: 16.h),
              if (widget.privacy != null)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.privacy!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.0.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.privacy![index]['title'] ?? '',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            widget.privacy![index]['content'] ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
