import 'package:flutter/material.dart';
// Make sure these imports match your project structure
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

import 'setup_congrats_view.dart';

class SetLocationView extends StatelessWidget {
  const SetLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Set Your Location"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            child: Container(
              color: AppColors.primaryLight.withOpacity(0.3),
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 150,
                  color: AppColors.primary,
                ),
                // You would put your Google Map widget here
              ),
            ),
          ),
          // Bottom Sheet
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, -5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Location",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                // Location Field
                TextFormField(
                  readOnly: true,
                  initialValue: "Times Square NYC, Manhattan",
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.location_on, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 30),
                // Continue Button
                PrimaryButton(
                  text: "Continue",
                  onPressed: () {
                    // Show the congratulations modal
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const CongratsView();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
