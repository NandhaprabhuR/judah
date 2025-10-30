import 'dart:async';
import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/bottom_navbar_view.dart';
import 'package:judah/screens/order_state_view.dart'; // Import OrderState
// Assuming the 'lottie' package is installed and imported:
import 'package:lottie/lottie.dart';

class OrderPlacedView extends StatefulWidget {
  final double orderTotal;
  const OrderPlacedView({super.key, required this.orderTotal});

  @override
  State<OrderPlacedView> createState() => _OrderPlacedViewState();
}

class _OrderPlacedViewState extends State<OrderPlacedView> {
  @override
  void initState() {
    super.initState();

    // 1. Update the Order State (Simulate placing the order globally)
    // This ensures the active order appears in the OrdersView tab.
    OrderState.placeNewOrder(widget.orderTotal);

    // 2. Set Timer for navigation after success animation (4 seconds total)
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        // Navigate to the main BottomNavBar (Home), clearing the checkout history.
        // This is the action taken after the user clicks "Apply" on the payment screen.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BottomNavbarView()),
              (Route<dynamic> route) => false,
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
            // --- LOTTIE ANIMATION WIDGET ---
            SizedBox(
              width: 250,
              height: 250,
              // Correctly use Lottie.asset as the child of the SizedBox.
              child: Lottie.asset(
                'assets/lottie/Done.json',
                repeat: false, // Ensure it plays only once
                onLoaded: (composition) {
                  // If you want the timer to start only after the animation loads,
                  // you would move the Timer logic here and adjust the duration.
                },
                errorBuilder: (context, error, stackTrace) {
                  // Fallback widget if the Lottie file cannot be found/loaded
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_outline, size: 150, color: AppColors.primary),
                  );
                },
              ),
            ),
            // ------------------------------------
            const SizedBox(height: 30),
            Text(
              "Your Order is Placed!",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 10),
            Text(
              "Total: \$${widget.orderTotal.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "You will be redirected to the Home page and can track your order in a few seconds.",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}