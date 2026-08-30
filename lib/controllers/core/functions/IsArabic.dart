bool isArabic(String text) {
  return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
}