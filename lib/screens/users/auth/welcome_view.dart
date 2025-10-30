import 'dart:async';
import 'package:flutter/material.dart';
import 'package:judah/screens/users/auth/splash_view.dart';
// Note: Make sure your import paths match your project name
import 'package:judah/screens/widgets/app_theme.dart';

// This is Screen 2: "Welcome to Foodu!"
class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    // Navigate to onboarding/splash screen after a delay
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SplashView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- UPDATED WIDGET ---
          // 1. Background Image
          // I'm assuming your bg image is in 'assets/images/'
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // Path to your background image
                image: const AssetImage('assets/images/welcome_bg.jpg'), // Corrected path
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  debugPrint('Image load error: $exception');
                },
              ),
            ),
            // Fallback color in case image fails
            child: Container(color: Colors.grey[800]?.withOpacity(0.5)),
          ),
          // ------------------------

          // 2. Dark Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          // 3. Content
          Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Judah! 👋",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.white.withOpacity(0.9)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}