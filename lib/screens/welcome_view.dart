import 'dart:async';
import 'package:flutter/material.dart';

import 'package:judah/screens/splash_view.dart';
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
        // Here, you would check if the user is new.
        // For this UI-only build, we'll always go to the SplashView.
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
          // 1. Background Image (Placeholder)
          Container(
            color: Colors.grey[800],
            child: const Center(
              child: Icon(
                Icons.image,
                color: Colors.grey,
                size: 200,
              ),
            ),
            // You would use your pizza image here:
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/pizza_bg.jpg'),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
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
                  "Welcome to Foodu! 👋",
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
