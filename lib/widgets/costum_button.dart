import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../typography.dart';
import '../view_models/onboarding_view_model.dart';
import '../styles.dart';  // Import the styles

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.controller,
  });

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Positioned(
        bottom: 40,
        right: 20,
        child: controller.currentPageIndex.value == 2
            ? ElevatedButton(
          style: AppStyles.onboardingButtonStyle(),  // Using the defined button style
          onPressed: () {
            controller.nextPage();
          },
          child: Text(AppLocalizations.of(context)!.getStarted, style: AppTypography.buttonText(16)),
        )
            : ElevatedButton(
          style: AppStyles.onboardingCircleButtonStyle(),  // Using the defined circle button style
          onPressed: () {
            controller.nextPage();
          },
          child: Icon(Icons.arrow_forward, color: AppColors.white),
        ),
      );
    });
  }
}
