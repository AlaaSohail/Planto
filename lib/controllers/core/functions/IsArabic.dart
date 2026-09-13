import 'package:flutter/material.dart';

bool isArabic(String text) {
  return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
}

bool isDark(context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  }
  return false;
}


