import 'package:flutter/material.dart';

class MultiColorText extends StatelessWidget {
  final List<TextSpanConfig> spans;
  final TextAlign textAlign;

  const MultiColorText({required this.spans, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: spans.map((span) {
          return TextSpan(text: span.text, style: span.style);
        }).toList(),
      ),
      textAlign: textAlign,
    );
  }
}

class TextSpanConfig {
  final String text;
  final TextStyle style;

  TextSpanConfig({required this.text, required this.style});
}
