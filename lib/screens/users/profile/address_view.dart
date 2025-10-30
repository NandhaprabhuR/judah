import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

// Screen 84: Address List
class AddressView extends StatelessWidget {
  const AddressView({super.key});

  final List<Map<String, dynamic>> _addresses = const [
    {"type": "Home", "address": "Times Square NYC, Manhattan. 27", "isDefault": true},
    {"type": "My Office", "address": "5259 Blue Bill Park, PC 4627", "isDefault": false},
    {"type": "My Apartment", "address": "21833 Clyde Gallagher, PC 4662", "isDefault": false},
    {"type": "Parent's House", "address": "6993 Meadow Valley Terra, PC 36", "isDefault": false},
    {"type": "My Villa", "address": "61480 Sunbrook Park, PC 5679", "isDefault": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text("Address"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                return _buildAddressCard(context, _addresses[index]);
              },
            ),
          ),
          // Add New Address Button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PrimaryButton(
              text: "Add New Address",
              onPressed: () {
                // TODO: Navigate to Add New Address screen
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, Map<String, dynamic> address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, color: AppColors.primary, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(address["type"], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    if (address["isDefault"])
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                          child: const Text("Default", style: TextStyle(color: AppColors.primary, fontSize: 12)),
                        ),
                      ),
                  ],
                ),
                Text(address["address"], style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded)),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, color: AppColors.textFaded)),
        ],
      ),
    );
  }
}