import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// Import necessary screens (new and existing)
import '../home/special_offers_view.dart';
import '../setup profile/setup_profile_view.dart';
import '../transactions/payment_method_view.dart';
import 'favorite_restaurant_view.dart';

import 'address_view.dart';
import 'notification_view.dart';
import 'help_center_view.dart';
import 'invite_friends_view.dart';

// Screen 80: User Profile
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Local state for the Dark Mode toggle
  bool _isDarkModeEnabled = false;

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Logout", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              Text("Are you sure you want to log out?", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context), // No
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: const Text("No"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement actual logout and navigate to AuthGateView
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logged out successfully.")),
                        );
                      }, // Yes (Simulated)
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("Yes"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          const SizedBox(width: 8)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 20),
            _buildSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://placehold.co/100x100/ADD8E6/000?text=Profile'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Andrew Ainsley", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                Text("+1 111 467 378 399", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              // Navigate to SetupProfileView (same screen used during initial setup)
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SetupProfileView()));
            },
          )
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          // --- Main Menu Items ---
          _buildMenuItem(context, Icons.favorite_border, "My Favorite Restaurants", const FavoriteRestaurantsView()),
          _buildMenuItem(context, Icons.local_offer_outlined, "Special Offers & Promo", const SpecialOffersView()),
          _buildMenuItem(context, Icons.credit_card, "Payment Methods", null, onTap: () {
            // Re-using the PaymentMethodsView class
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaymentMethodsView()));
          }),
          const SizedBox(height: 16),

          // --- General Settings ---
          _buildMenuItem(context, Icons.person_outline, "Profile", null, onTap: () {
            // Re-using the SetupProfileView class
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SetupProfileView()));
          }),
          _buildMenuItem(context, Icons.location_on_outlined, "Address", const AddressView()),
          _buildMenuItem(context, Icons.notifications_outlined, "Notification", const NotificationView()),
          _buildMenuItem(context, Icons.security, "Security", null), // Security
          _buildMenuItem(context, Icons.language, "Language", null, subText: "English (US)"), // Language

          // --- Toggle Item (Dark Mode) ---
          _buildToggleItem(context, Icons.dark_mode_outlined, "Dark Mode", _isDarkModeEnabled, (value) {
            setState(() {
              _isDarkModeEnabled = value;
            });
            // TODO: Implement actual theme switch
          }),

          // --- Support and Invites ---
          _buildMenuItem(context, Icons.help_outline, "Help Center", const HelpCenterView()),
          _buildMenuItem(context, Icons.group_outlined, "Invite Friends", const InviteFriendsView()),

          // --- Logout Button (Special Item) ---
          const SizedBox(height: 24),
          _buildLogoutItem(context),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Generic Menu Item Builder
  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Widget? destination, {String? subText, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {
        if (destination != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => destination));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textDark, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
            ),
            if (subText != null)
              Text(subText, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textFaded)),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textFaded, size: 16),
          ],
        ),
      ),
    );
  }

  // Toggle Item Builder (for Dark Mode)
  Widget _buildToggleItem(BuildContext context, IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textDark, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  // Logout Button Builder
  Widget _buildLogoutItem(BuildContext context) {
    return InkWell(
      onTap: () => _showLogoutConfirmation(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            const Icon(Icons.logout, color: Colors.red, size: 24),
            const SizedBox(width: 16),
            Text("Logout", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}