import 'dart:async';
import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/bottom_navbar_view.dart';
import 'package:judah/screens/order_state_view.dart'; // Import OrderState
import 'package:lottie/lottie.dart'; // Lottie package used

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

    // 1. Update the Order State
    OrderState.placeNewOrder(widget.orderTotal);

    // 2. Set Timer for auto-navigation after 4 seconds
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        // Navigate to the main BottomNavBar (Home), clearing the checkout history.
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
            // --- LOTTIE ANIMATION WIDGET (Minimal Error Fallback) ---
            Lottie.asset(
              'assets/animations/Done.json',
              width: 250,
              height: 250,
              repeat: false,
              errorBuilder: (context, error, stackTrace) {
                // FALLBACK: Returns an empty box if the asset cannot be loaded.
                // This forces you to see a gap if the Lottie path is incorrect.
                return const SizedBox(
                  width: 250,
                  height: 250,
                );
              },
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
              "Thankyou",
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