import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/typography.dart';
import '/view_models/onboarding_view_model.dart';

class OnBoardingskip extends StatelessWidget {
  const OnBoardingskip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      right: MediaQuery.of(context).size.height * 0.04,
      child: TextButton(
        onPressed: () {
          OnboardingController.instance.skipPage();
        },
        child: Text(
          AppLocalizations.of(context)!.skipButton, // Using the constant from AppText
          style: AppTypography.skipButton(16),
        ),
      ),
    );
  }
}
