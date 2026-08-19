import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpgradePlanCard extends StatelessWidget {
  const UpgradePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      color: Colors.white,
      child: Column(
        children: [
          Text('FREE'),
          Row(children: [Text("0\$"), Text("/forever")]),
        ],
      ),
    );
  }
}
