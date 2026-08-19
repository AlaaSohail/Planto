import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,

    this.content,
    this.onPressed,
    this.icon,
    this.mainAxisSize,
    this.buttonStyle,
    this.textStyle,
  });

  final String? content;
  final FutureOr<void> Function()? onPressed;
  final Widget? icon;
  final MainAxisSize? mainAxisSize;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed!,
      child: Row(
        mainAxisSize: mainAxisSize!,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              content!,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (icon != null) ...[SizedBox(width: 8.w), icon!],
        ],
      ),
    );
  }
}
