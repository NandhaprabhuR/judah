
import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

import 'cancel_orders_state_view.dart';

// Screen 63: Cancel Order Reason Selection
class CancelOrderView extends StatefulWidget {
  const CancelOrderView({super.key});

  @override
  State<CancelOrderView> createState() => _CancelOrderViewState();
}

class _CancelOrderViewState extends State<CancelOrderView> {
  String? _selectedReason;
  final TextEditingController _othersController = TextEditingController();

  final List<String> _reasons = const [
    "Waiting for long time",
    "Unable to contact driver",
    "Driver denied to go to destination",
    "Driver denied to come to pickup",
    "Wrong address shown",
    "The price is not reasonable",
    "I want to order another restaurant",
    "I just want to cancel",
  ];

  @override
  void dispose() {
    _othersController.dispose();
    super.dispose();
  }

  void _submitCancellation(BuildContext context) {
    // Basic validation logic
    if (_selectedReason == null && _othersController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a reason or specify one.")),
      );
      return;
    }

    // Navigate to the success screen with replacement to clear this view
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CancelSuccessView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Cancel Order"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please select the reason for cancellation:",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // --- Reason Radio Buttons ---
            ..._reasons.map((reason) => _buildReasonRadio(reason)).toList(),

            const SizedBox(height: 24),

            // --- Others Section ---
            Text(
              "Others",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _othersController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Others reason...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                fillColor: AppColors.white, // Override theme to make background white
                filled: true,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 40),

            // --- Submit Button ---
            PrimaryButton(
              text: "Submit",
              onPressed: () => _submitCancellation(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonRadio(String reason) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedReason = reason;
          });
          _othersController.clear(); // Clear 'Others' if a radio is selected
        },
        child: Row(
          children: [
            Radio<String>(
              value: reason,
              groupValue: _selectedReason,
              onChanged: (String? value) {
                setState(() {
                  _selectedReason = value;
                });
                _othersController.clear();
              },
              activeColor: AppColors.primary,
            ),
            Expanded(
              child: Text(
                reason,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}