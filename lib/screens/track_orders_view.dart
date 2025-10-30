import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/bottom_navbar_view.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

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

      // 2. Place the "Back to Home" button reliably at the bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PrimaryButton(
          text: "Back to Home",
          onPressed: () {
            // Navigate to BottomNavbarView, clearing the tracking screen from history
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const BottomNavbarView()),
                  (Route<dynamic> route) => false,
            );
          },
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