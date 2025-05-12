import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pretium/core/theme/app_colors.dart';
import 'package:pretium/features/onboarding/presentation/onboarding_screen.dart';

/// SplashScreen serves as the initial screen of the application
/// It displays the app logo/name for a set duration before navigating to the onboarding flow
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate away from splash screen after 2 seconds
    Timer(const Duration(seconds: 4), () {
      // Navigate to onboarding screen and remove splash from navigation stack
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use primary color for background
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo can be added here as an image when available
            // For now, using a placeholder text logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // App name
            const Text(
              'PRETIUM',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Tagline or description
            Text(
              'Simplifying crypto payments',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 