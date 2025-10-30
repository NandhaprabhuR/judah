import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:judah/screens/widgets/bottom_navbar_view.dart'; // CORRECTED IMPORT: Use BottomNavbarView

// This is Screen 52: Driver Tracking
class DriverHeadingView extends StatelessWidget {
  const DriverHeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- 1. Map Placeholder ---
          Positioned.fill(
            child: Container(
              color: AppColors.primaryLight.withOpacity(0.5),
              child: const Center(
                // Placeholder for the map and route line
                child: Icon(Icons.map_outlined, size: 200, color: AppColors.primary),
              ),
            ),
          ),

          // --- 2. Custom AppBar (Back Button & Menu) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircularIcon(Icons.arrow_back_ios, () => Navigator.of(context).pop()),
                  _buildCircularIcon(Icons.more_vert, () {}),
                ],
              ),
            ),
          ),

          // --- 3. Bottom Driver Info Card (Pinned) ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, -4)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Driver is heading to the restaurant...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  _buildDriverDetails(context),
                  const SizedBox(height: 30),
                  _buildActionButtons(),
                  const SizedBox(height: 16),

                  // --- Back to Home Button (Fixed Navigation) ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to BottomNavbarView, clearing all previous routes
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const BottomNavbarView()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      child: const Text("Back to Home"),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIcon(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: IconButton(icon: Icon(icon, color: AppColors.textDark), onPressed: onTap),
    );
  }

  Widget _buildDriverDetails(BuildContext context) {
    return Row(
      children: [
        // Driver Avatar
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://placehold.co/100x100/A3E4D7/000?text=Driver'),
        ),
        const SizedBox(width: 16),
        // Driver Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rayford Chenail", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Text("Yamaha MX King", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded)),
            ],
          ),
        ),
        // Rating
        Row(
          children: [
            const Icon(Icons.star, color: Colors.orange, size: 18),
            const SizedBox(width: 4),
            Text("4.8", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: 8),
            Text("HSW 4736 XK", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textFaded)),
          ],
        )
      ],
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.white),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildActionButtons() {
    // Buttons for Cancel, Chat, Call
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Cancel
        _buildActionButton(Icons.close, () {}, Colors.red),
        // Chat
        _buildActionButton(Icons.chat_bubble_outline, () {}, AppColors.primary),
        // Call
        _buildActionButton(Icons.call, () {
          // TODO: Implement call action
        }, AppColors.primary),
      ],
    );
  }
}