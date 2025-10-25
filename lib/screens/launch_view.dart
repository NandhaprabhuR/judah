import 'dart:async';
import 'package:flutter/material.dart';
// Note: Make sure your import path matches your project name
// If your project folder is 'judah', this is correct:
import 'package:judah/screens/welcome_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
// If your project folder is 'foodu_app_ui', it would be:
// import 'package:foodu_app_ui/screens/welcome_view.dart';
// import 'package:foodu_app_ui/theme/app_theme.dart';


// This is Screen 1: Logo + Spinner
class LaunchView extends StatefulWidget {
  const LaunchView({super.key});

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  @override
  void initState() {
    super.initState();
    // Simulate app loading
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WelcomeView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // --- UPDATED WIDGET ---
            // 1. Your "Foodu" Logo
            // Path now matches your screenshot
            Image.asset(
              'assets/logo/img.png', // Corrected path
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.fastfood_rounded,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
            // ------------------------

            const SizedBox(height: 24),
            Text(
              "Judah",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 100),
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}