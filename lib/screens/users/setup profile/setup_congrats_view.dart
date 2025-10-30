import 'dart:async';
import 'package:flutter/material.dart';
// Make sure these imports match your project structure
import 'package:judah/screens/widgets/app_theme.dart';

import '../bottom navbar/bottom_navbar_view.dart';

class CongratsView extends StatefulWidget {
  const CongratsView({super.key});

  @override
  State<CongratsView> createState() => _CongratsViewState();
}

class _CongratsViewState extends State<CongratsView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        // Navigate to the Home Screen (BottomNavbarView) and
        // remove all previous routes from the stack.
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BottomNavbarView()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.person,
                size: 80,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 30),
            // Text
            Text(
              "Congratulations!",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Your account is ready to use. You will be redirected to the Home page in a few seconds..",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Spinner
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
