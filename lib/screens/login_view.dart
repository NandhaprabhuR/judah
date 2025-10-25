import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:judah/screens/signup_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

import '../auth_gate_view.dart';
import 'otp_view.dart';

// This is Screen 6: "Login to Your Account" (Phone Login)
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo Placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.fastfood,
                  size: 50, color: AppColors.primary),
            ),
            const SizedBox(height: 30),
            Text(
              "Login to Your Account",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 30),

            // Phone Number Field
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "+1 000 000 000",
                prefixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 10, 0),
                  // This is a placeholder for a country code picker
                  child: Text("🇺🇸", style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Remember me
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
                Text(
                  "Remember me",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Sign in Button
            PrimaryButton(
              text: "Sign in",
              onPressed: () {
                // Navigate to OTP screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const OtpView(
                      phoneNumber: "+1 111 ******99", // Pass dummy number
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),

            // "or continue with" Divider
            const OrDivider(),
            const SizedBox(height: 40),

            // Google Button
            SocialButton(
              onPressed: () {
                // TODO: Handle Google Sign In
              },
              icon: FontAwesomeIcons.google,
              text: "Continue with Google",
              iconColor: Colors.red,
            ),
            const SizedBox(height: 60),

            // Sign up text
            Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "Sign up",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const SignupView()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
