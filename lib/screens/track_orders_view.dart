import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/bottom_navbar_view.dart';
import 'package:judah/screens/widgets/buttons_theme.dart'; // PrimaryButton is not needed, but good practice

// This is the new dedicated Driver/Order Tracking screen
class TrackOrdersView extends StatelessWidget {
  const TrackOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- 1. Map and Route Visual ---
          Positioned.fill(
            child: Container(
              color: AppColors.cardBackground, // Light grey background
              child: Stack(
                children: [
                  // Placeholder for the full map view (Light green streets)
                  Center(
                    child: Opacity(
                      opacity: 0.8,
                      child: Image.network(
                        'https://placehold.co/800x1200/E6F7EB/00B14F?text=Map',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.map, size: 300, color: AppColors.primaryLight);
                        },
                      ),
                    ),
                  ),

                  // 2. Route Line (Simplified curve over map)
                  // In a real app, this would be drawn with CustomPainter or a map library.
                  const Positioned(
                    top: 200,
                    left: 50,
                    right: 50,
                    child: Icon(Icons.route, size: 200, color: AppColors.primary),
                  ),

                  // 3. Driver Marker (Green circle with profile image)
                  Positioned(
                    top: 150,
                    left: 150,
                    child: _buildTrackingMarker(
                        context,
                        Icons.person,
                        AppColors.primary,
                        isDriver: true
                    ),
                  ),

                  // 4. Destination Marker (Bottom right)
                  Positioned(
                    bottom: 50,
                    right: 50,
                    child: _buildTrackingMarker(
                        context,
                        Icons.location_on,
                        AppColors.primary
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 2. Custom AppBar (Back Button & Battery Status) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCircularIcon(Icons.arrow_back, () => Navigator.of(context).pop()),
            ),
          ),

          // --- 3. Fixed Bottom Button (Back to Home) ---
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
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
        ],
      ),
    );
  }

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

  Widget _buildTrackingMarker(BuildContext context, IconData icon, Color color, {bool isDriver = false}) {
    // If it's the driver, show the profile picture/avatar style
    if (isDriver) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Outer circle
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          // Inner avatar
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://placehold.co/100x100/A3E4D7/000?text=Driver'),
          ),
        ],
      );
    }
    // If it's a generic marker
    return Icon(icon, size: 40, color: color);
  }
}