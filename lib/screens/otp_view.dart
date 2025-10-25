import 'package:flutter/material.dart';
// Make sure these imports match your project structure
import 'package:judah/screens/setup_profile_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';
import 'package:pinput/pinput.dart';

// This is Screen 7: "OTP Code Verification"
class OtpView extends StatefulWidget {
  final String phoneNumber;
  const OtpView({super.key, required this.phoneNumber});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  // TODO: Add a real timer
  final String _resendTimer = "55";

  @override
  Widget build(BuildContext context) {
    // Pinput theme (keep all your existing theme code)
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: Theme.of(context).textTheme.headlineSmall,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.primaryLight,
        border: Border.all(color: AppColors.primary),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("OTP Code Verification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              "Code has been send to ${widget.phoneNumber}",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // OTP Input Field
            Pinput(
              length: 4,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) {
                // TODO: Verify PIN
                print("Completed: $pin");
              },
            ),
            const SizedBox(height: 40),

            // Resend code
            Text.rich(
              TextSpan(
                text: "Resend code in ",
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "${_resendTimer}s",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // --- UPDATED BUTTON ---
            PrimaryButton(
              text: "Verify",
              onPressed: () {
                // TODO: Add verification logic
                // On success, navigate to Profile Setup
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SetupProfileView(),
                  ),
                );
              },
            ),
            // ---------------------
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

