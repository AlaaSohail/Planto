import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {@override
void initState() {
  super.initState();
}

@override
void dispose() {
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7fbf5),
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        title: AppTheme.plantCareAILogo(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AppTheme.backButton(context),
      ),
    );
  }
}
