import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/core/functions/IsArabic.dart';
import '../themes/app_colors.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.suffix,
    this.prefix,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,

      textDirection: isArabic(widget.controller.text)
          ? TextDirection.rtl
          : TextDirection.ltr,

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
      style: textTheme.bodyMedium?.copyWith(
        color: isDark ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),

      cursorColor: AppColors.primary,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
