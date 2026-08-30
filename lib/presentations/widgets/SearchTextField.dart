import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class SearchTextField extends StatefulWidget {
  SearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffix,
    this.prefix,
    this.validator,
    this.onChange,
  });

  IconButton? suffix;
  Icon? prefix;
  String hintText;
  String? Function(String?)? validator;
  String? Function(String?)? onChange;
  TextEditingController controller;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ).r,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 0.5.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 0.5.w),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2.w),
        ),
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefix,
      ),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
      ),
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
    );
  }
}
