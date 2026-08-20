import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/cubit/community_cubit/community_cubit.dart';
import '../themes/app_colors.dart';
import 'AuthTextField.dart';

class ModalBottomSheet extends StatelessWidget {
  ModalBottomSheet({
    super.key,
    required this.hintText,
    required this.actionText,
    required this.onPress,
    required this.title,
    this.controller,
  });

  final TextEditingController? controller;

  final String hintText;

  final String? title;

  final String? actionText;

  final FutureOr<void> Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: actionText == "Deploy"
                  ? AppColors.textPrimary
                  : AppColors.error,
            ),
          ),
          SizedBox(height: 16.h),
          if (controller == null)
            Text(hintText, style: Theme.of(context).textTheme.bodyLarge),
          if (controller != null)
            AuthTextField(
              controller: controller!,
              hintText: hintText,

              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a post';
                }
                return null;
              },
              keyboardType: TextInputType.text,
            ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: onPress!,
                child: Text(
                  actionText!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: actionText == "Deploy"
                        ? AppColors.textPrimary
                        : AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
