import 'package:flutter/material.dart';

import 'package:judah/screens/launch_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodu UI',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // We start the app flow with the LaunchView
      home: const LaunchView(),
    );
  }
}
