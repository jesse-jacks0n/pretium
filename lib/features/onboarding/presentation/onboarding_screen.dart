import 'package:flutter/material.dart';
import 'package:pretium/core/theme/app_colors.dart';
import 'package:pretium/core/theme/app_icons.dart';
import 'package:pretium/features/onboarding/models/onboarding_model.dart';
import 'package:pretium/features/auth/presentation/login_screen.dart';

/// OnboardingScreen is shown to first-time users
/// It presents a series of screens to introduce key app features
/// Users can swipe through pages or use buttons to navigate
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Controller for managing page transitions
  late PageController _pageController;

  /// Tracks the currently visible page index
  int _currentPage = 0;

  /// Defines content and appearance of each onboarding page
  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: 'Direct Pay',
      description: 'Pay with crypto across Africa effortlessly',
      icon: AppIcons.cardIcon(size: 60),

    ),
    OnboardingModel(
      title: 'Accept Payments',
      description: 'Accept stablecoin payments hassle-free',
      icon: AppIcons.walletIcon(size: 60),
    ),
    OnboardingModel(
      title: 'Pay Bills',
      description: 'Pay for utility services and earn rewards',
      icon: AppIcons.billIcon(size: 60),
      isLastPage: true,
      buttonText: 'Get Started',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize page controller for the PageView
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Clean up resources
    _pageController.dispose();
    super.dispose();
  }

  /// Handles next button press or final page completion
  void _onNextPressed() {
    if (_currentPage == _pages.length - 1) {
      // On last page, proceed to login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Otherwise, go to next page with animation
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Handles skip button press to bypass onboarding
  void _onSkipPressed() {
    // Skip directly to login page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at top right
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _onSkipPressed,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            // Main content area with swipeable pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page indicator dots showing current position
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildDotIndicator(index),
                ),
              ),
            ),

            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _pages[_currentPage].buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Builds a single onboarding page with icon, title and description
  Widget _buildPage(OnboardingModel page) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Feature icon in circular container
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Center(child: page.icon),
          ),
          const SizedBox(height: 48),

          // Feature title
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Feature description
          Text(
            page.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds a single dot indicator for the page position
  /// Active dot is elongated to create pill shape
  Widget _buildDotIndicator(int index) {
    bool isActive = index == _currentPage;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color:
            isActive ? AppColors.indicatorActive : AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
