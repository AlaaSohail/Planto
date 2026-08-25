import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {@override
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
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        leading: AppTheme.backButton(context),
      ),
    );
  }
}
