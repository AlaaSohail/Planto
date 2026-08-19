import 'package:flutter/material.dart';

import '../../../controllers/cache/cache_helper.dart';
import '../../../controllers/services/service_locator.dart';
import '../../themes/app_theme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        leading: AppTheme.backButton(context),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {}
}
