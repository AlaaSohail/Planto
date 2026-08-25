import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/cubit/community_cubit/community_cubit.dart';
import '../../controllers/cubit/plant_cubit/plant_cubit.dart';
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
    this.child,
  });

  final TextEditingController? controller;

  final String hintText;

  final String? title;

  final String? actionText;

  final Widget? child;

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
          if (child == null) SizedBox(height: 8.h),
          BlocBuilder<CommunityCubit, CommunityState>(
            builder: (context, state) {
              final postImage = context.read<CommunityCubit>().postImage;

              if (postImage == null) {
                return const SizedBox.shrink();
              }
              if (state is UploadPostImageLoading) {
                CircularProgressIndicator.adaptive();
              }

              return Container(
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: FileImage(File(postImage.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          if (child == null) SizedBox(height: 16.h),
          if (controller == null)
            Text(hintText, style: Theme.of(context).textTheme.bodyLarge),
          if (child != null) child!,
          if (controller != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AuthTextField(
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
                ),
                SizedBox(width: 16.w),
                IconButton.filledTonal(
                  onPressed: () {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then(
                          (value) => context
                              .read<CommunityCubit>()
                              .uploadPostImage(value!),
                        );
                  },
                  icon: Image.asset(
                    'assets/images/camera.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ],
            ),

          SizedBox(height: 16.h),

          if (child == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller!.clear();
                    context.read<CommunityCubit>().postImage = null;
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
