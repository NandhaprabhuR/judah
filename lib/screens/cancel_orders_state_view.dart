import 'dart:async';
import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/bottom_navbar_view.dart';
import 'package:judah/screens/order_state_view.dart';
import 'package:lottie/lottie.dart';

// Screen 64: Cancellation Success/Sad Dialog
class CancelSuccessView extends StatefulWidget {
  const CancelSuccessView({super.key});

  @override
  State<CancelSuccessView> createState() => _CancelSuccessViewState();
}

class _CancelSuccessViewState extends State<CancelSuccessView> {
  @override
  void initState() {
    super.initState();

    // Clear the active order state immediately upon successful cancellation
    OrderState.completeActiveOrder();

    // Set Timer for auto-navigation after 4 seconds (1 second longer than the timer in the dialog itself)
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        // Navigate to the main BottomNavbar (Home), clearing the cancellation history.
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BottomNavbarView()),
              (Route<dynamic> route) => false,
        );
      }
    });

    // Show the dialog immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // This ensures the dialog is visible and blocks interaction
          return _buildSuccessDialog(context);
        },
      );
    });
  }

  // A placeholder to match the sad emoji graphic
  Widget _buildSadEmoji() {
    return Lottie.asset(
      'assets/animations/sad_emoji.json', // Placeholder path for a sad Lottie animation
      width: 100,
      height: 100,
      repeat: true,
      errorBuilder: (context, error, stackTrace) {
        // Fallback Icon: Sad face emoji icon
        return const Center(
          child: Text(
            "😔",
            style: TextStyle(fontSize: 80),
          ),
        );
      },
    );
  }

  Widget _buildSuccessDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSadEmoji(),
            const SizedBox(height: 20),
            Text(
              "We're so sad about your cancellation",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "We will continue to improve our service & satisfy you on the next order.",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // This OK button is primarily for user acknowledgment before the auto-navigation takes over
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                child: const Text("OK"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // The main build function returns a minimal container, as the dialog covers the screen.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}