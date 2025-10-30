import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';
// REMOVED IMPORT: import 'driver_heading_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'orders_placedview.dart';

// This is Screen 47: Payment Methods
class PaymentMethodsView extends StatefulWidget {
  const PaymentMethodsView({super.key});

  @override
  State<PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsView> {
  String? _selectedMethod;

  final List<Map<String, dynamic>> _methods = const [
    {"name": "My Wallet", "value": "wallet", "icon": Icons.account_balance_wallet, "color": AppColors.primary, "balance": "\$9.379"},
    {"name": "PayPal", "value": "paypal", "icon": FontAwesomeIcons.paypal, "color": Color(0xFF00457C)},
    {"name": "Google Pay", "value": "google", "icon": FontAwesomeIcons.googlePay, "color": AppColors.textDark},
    {"name": "Apple Pay", "value": "apple", "icon": FontAwesomeIcons.apple, "color": AppColors.textDark},
    {"name": "Cash Money", "value": "cash", "icon": Icons.monetization_on, "color": Colors.green},
    {"name": "**** **** **** 4679", "value": "card", "icon": FontAwesomeIcons.ccMastercard, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    // NOTE: Using a dummy total (104.00) as the real total is not passed to this screen
    const double dummyTotal = 104.00;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Payment Methods"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code_scanner)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ..._methods.map((method) => _buildMethodRow(method)).toList(),
                  const SizedBox(height: 16),

                  // --- Manual Styling for "Add New Card" button ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Handle Add New Card logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight, // Light Green background
                        foregroundColor: AppColors.primary, // Green text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0, // No shadow
                        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primary),
                      ),
                      child: const Text("Add New Card"),
                    ),
                  ),
                ],
              ),
            ),

            // --- "Apply" button using PrimaryButton ---
            PrimaryButton(
              text: "Apply",
              onPressed: _selectedMethod == null
                  ? () {} // Set to an empty function when disabled
                  : () {
                // Navigate to the Order Placed success screen after payment is selected
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const OrderPlacedView(orderTotal: dummyTotal)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodRow(Map<String, dynamic> method) {
    final bool isSelected = _selectedMethod == method["value"];

    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = method["value"];
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            // Icon/Logo
            Icon(method["icon"], color: method["color"], size: 30),

            const SizedBox(width: 16),
            // Name
            Text(method["name"], style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            // Balance/Spacer
            if (method["balance"] != null)
              Text(method["balance"], style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            // Selection Circle
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.textFaded, width: 2),
                color: isSelected ? AppColors.primary : AppColors.white,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: AppColors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}