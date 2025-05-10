import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../view_models/onboarding_view_model.dart';
import '../widgets/OnBoardingDotNavigation.dart';
import '../widgets/OnBoardingPage.dart';
import '../widgets/OnBoardingSkip.dart';
import 'package:get/get.dart';
import '../widgets/costum_button.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: 'assets/onb1.png',
                title: AppLocalizations.of(context)!.welcomeTitle,
                subtitle: AppLocalizations.of(context)!.welcomeSubtitle,
              ),
              OnBoardingPage(
                image: 'assets/onb2.png',
                title: AppLocalizations.of(context)!.exploreServicesTitle,
                subtitle: AppLocalizations.of(context)!.exploreServicesSubtitle,
              ),
              OnBoardingPage(
                image: 'assets/onb3.png',
                title: AppLocalizations.of(context)!.startTodayTitle,
                subtitle: AppLocalizations.of(context)!.startTodaySubtitle,
              ),
            ],
          ),
          OnBoardingskip(),
          OnBoardingDotNavigation(),
          OnboardingButton(controller: controller),
        ],
      ),
    );
  }
}
