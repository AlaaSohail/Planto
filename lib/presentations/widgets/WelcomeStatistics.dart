import 'package:flutter/material.dart';

class WelcomeStatistics extends StatelessWidget {
  const WelcomeStatistics({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
  });

  final String title;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(value, style: Theme.of(context).textTheme.bodySmall),
            Text(unit, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),

        Text(title, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
