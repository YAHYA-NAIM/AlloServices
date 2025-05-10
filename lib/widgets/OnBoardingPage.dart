import 'package:flutter/material.dart';
import '/typography.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          SizedBox(height: 60),
          Image.asset(image),
          Text(
            title,
            style: AppTypography.title(32),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 26),
          Text(
            subtitle,
            style: AppTypography.description(15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
