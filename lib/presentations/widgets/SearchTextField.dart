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
        hintText: widget.hintText,
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefix,
        errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
    );
  }
}
