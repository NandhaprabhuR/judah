import 'dart:async';
import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// Screen 79: Top Up Successful Dialog
class TopUpSuccessView extends StatefulWidget {
  final double topUpAmount;
  const TopUpSuccessView({super.key, required this.topUpAmount});

  @override
  State<TopUpSuccessView> createState() => _TopUpSuccessViewState();
}

class _TopUpSuccessViewState extends State<TopUpSuccessView> {

  @override
  void initState() {
    super.initState();

    // Set Timer for auto-navigation after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Pop the dialog first
        Navigator.of(context, rootNavigator: true).pop();

        // Then navigate back to the EWalletView (or Orders tab, if that's the ultimate goal)
        // Standard flow returns to the wallet screen. We'll pop until we are back at the EWalletView in the nav stack.
        Navigator.of(context).popUntil((route) => route.isFirst); // Assumes EWalletView is reached by popping to root or the initial BottomNavBar
      }
    });

    // We do NOT call showDialog here, as TopUpView is already calling this widget inside a showDialog call.
    // The dialog itself is built directly in the build method.
  }

  // A placeholder to match the Wallet graphic
  Widget _buildWalletGraphic() {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: const Icon(Icons.account_balance_wallet, color: AppColors.white, size: 60),
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
            _buildWalletGraphic(),
            const SizedBox(height: 20),
            Text(
              "Top Up Successful!",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "You have successfully top up up e-wallet for \$${widget.topUpAmount.toStringAsFixed(0)}",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Pop the dialog, letting the timer handle the rest of the navigation
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text("OK"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Return the dialog directly as TopUpView shows this widget inside a showDialog call.
    return _buildSuccessDialog(context);
  }
}