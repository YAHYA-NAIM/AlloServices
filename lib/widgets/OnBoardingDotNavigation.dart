import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../colors.dart';
import '../view_models/onboarding_view_model.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width * 0.05,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        count: 3,
        onDotClicked: controller.doNavigationClick,
        effect: WormEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: AppColors.primary,
          dotColor: Colors.grey.shade300,
        ),
      ),
    );
  }
}
