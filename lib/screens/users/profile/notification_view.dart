
import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// Screen 85: Notification Settings
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  // Initial state derived from the screenshot
  final Map<String, bool> _settings = {
    "General Notification": true,
    "Sound": true,
    "Vibrate": false,
    "Special Offers": true,
    "Promo & Discount": false,
    "Payments": true,
    "Cashback": false,
    "App Updates": true,
    "New Service Available": false,
    "New Tips Available": false,
  };

  void _toggleSetting(String key, bool value) {
    setState(() {
      _settings[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text("Notification"),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: _settings.keys.map((key) => _buildNotificationToggle(context, key)).toList(),
      ),
    );
  }

  Widget _buildNotificationToggle(BuildContext context, String title) {
    bool isActive = _settings[title]!;

    // Determine if it's a section divider (General Notification, Payments, etc.)
    bool isPrimary = ["General Notification", "Payments"].contains(title);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
                color: isPrimary ? AppColors.textDark : AppColors.textLight,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: isActive,
              onChanged: (value) => _toggleSetting(title, value),
              activeColor: AppColors.primary,
              inactiveTrackColor: AppColors.cardBackground,
            ),
          ),
        ],
      ),
    );
  }
}