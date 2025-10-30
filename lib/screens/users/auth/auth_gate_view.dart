import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:judah/screens/users/auth/signup_view.dart';

import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

import 'login_view.dart';

// This is Screen 5 (Left): "Let's you in"
class AuthGateView extends StatelessWidget {
  const AuthGateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Illustration Placeholder
              Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(Icons.people_alt_rounded,
                      size: 100, color: AppColors.border),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Let's you in",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 30),

              // Google Button
              SocialButton(
                onPressed: () {
                  // TODO: Handle Google Sign In
                },
                icon: FontAwesomeIcons.google,
                text: "Continue with Google",
                iconColor: Colors.red, // Google's brand color
              ),
              const SizedBox(height: 30),

              // "or" Divider
              const OrDivider(),
              const SizedBox(height: 30),

              // Sign in with Phone Button
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginView()),
                  );
                },
                text: "Sign in with Phone Number",
              ),
              const Spacer(),

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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const SignupView()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget for the "or" divider
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "or",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textFaded),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
      ],
    );
  }
}
