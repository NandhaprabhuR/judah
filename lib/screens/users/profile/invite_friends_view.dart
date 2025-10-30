import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// Screen 88/89: Invite Friends
class InviteFriendsView extends StatefulWidget {
  const InviteFriendsView({super.key});

  @override
  State<InviteFriendsView> createState() => _InviteFriendsViewState();
}

class _InviteFriendsViewState extends State<InviteFriendsView> {
  // Dummy contacts list
  final List<Map<String, dynamic>> _contacts = [
    {"name": "Lauralee Quintero", "phone": "+1-300-555-0135", "invited": false, "image": "https://placehold.co/100x100/A0D2E8/000?text=LQ"},
    {"name": "Annabel Rohan", "phone": "+1-202-555-0136", "invited": true, "image": "https://placehold.co/100x100/FF5733/000?text=AR"},
    {"name": "Alfonzo Schuessler", "phone": "+1-300-555-0119", "invited": false, "image": "https://placehold.co/100x100/9CCC65/000?text=AS"},
    {"name": "Augustina Midgett", "phone": "+1-300-555-0161", "invited": false, "image": "https://placehold.co/100x100/E0BBE4/000?text=AM"},
    {"name": "Freida Varnes", "phone": "+1-300-555-0136", "invited": true, "image": "https://placehold.co/100x100/FFD700/000?text=FV"},
    {"name": "Francene Vandyne", "phone": "+1-202-555-0167", "invited": false, "image": "https://placehold.co/100x100/87CEEB/000?text=FV"},
    {"name": "Geoffrey Mott", "phone": "+1-202-555-0119", "invited": false, "image": "https://placehold.co/100x100/388E3C/000?text=GM"},
    {"name": "Rayford Chenail", "phone": "+1-202-555-0171", "invited": true, "image": "https://placehold.co/100x100/FFA000/000?text=RC"},
    {"name": "Florencio Dorrance", "phone": "+1-300-555-0171", "invited": false, "image": "https://placehold.co/100x100/B0E0E6/000?text=FD"},
    {"name": "Kylee Danford", "phone": "+1-202-555-0171", "invited": false, "image": "https://placehold.co/100x100/E91E63/000?text=KD"},
  ];

  void _toggleInvite(int index) {
    setState(() {
      _contacts[index]["invited"] = !(_contacts[index]["invited"] as bool);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text("Invite Friends"),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          return _buildContactRow(context, _contacts[index], index);
        },
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, Map<String, dynamic> contact, int index) {
    bool isInvited = contact["invited"] as bool;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(contact["image"]),
            backgroundColor: AppColors.primaryLight,
          ),
          const SizedBox(width: 16),
          // Name and Phone
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact["name"], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text(contact["phone"], style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded)),
              ],
            ),
          ),
          // Invite Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () => _toggleInvite(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: isInvited ? AppColors.white : AppColors.primary,
                foregroundColor: isInvited ? AppColors.primary : AppColors.white,
                side: isInvited ? const BorderSide(color: AppColors.primary, width: 1) : BorderSide.none,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 0),
              ),
              child: Text(isInvited ? "Invited" : "Invite", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}