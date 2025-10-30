import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

import '../bottom navbar/bottom_navbar_view.dart';
import 'cancel_order_view.dart'; // NEW IMPORT for the Cancel screen

// This is the new dedicated Driver/Order Tracking screen
class TrackOrdersView extends StatelessWidget {
  const TrackOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Center the Map Icon (The main screen content)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Map Icon (Large)
            const Icon(
                Icons.map_outlined,
                size: 200,
                color: AppColors.primary
            ),
            const SizedBox(height: 30),
            Text(
              "Tracking Active",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),

      // 2. Place BOTH buttons reliably at the bottom using Column
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Essential to constrain the Column size
          children: [
            // --- NEW: Cancel Order Button (Outlined/Secondary Style) ---
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to the cancellation reason selection screen
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CancelOrderView()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: const BorderSide(color: Colors.red, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Cancel Order",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16), // Space between buttons

            // --- Back to Home Button (Primary Style) ---
            PrimaryButton(
              text: "Back to Home",
              onPressed: () {
                // Navigate to BottomNavbarView, clearing the tracking screen from history
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const BottomNavbarView()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),

      // 3. Floating Action for the optional top-left icon (for the back function)
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: _buildCircularIcon(Icons.arrow_back, () => Navigator.of(context).pop()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }

  // Helper widget for the circular back button (kept for visual style)
  Widget _buildCircularIcon(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.8),
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: IconButton(icon: Icon(icon, color: AppColors.textDark), onPressed: onTap),
    );
  }
}