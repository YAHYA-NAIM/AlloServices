import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  static TextStyle label(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF444D6E),
    );
  }

  static TextStyle info(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      color: const Color(0xFF7C849D),
    );
  }

  static TextStyle skipButton(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF6759FF),
    );
  }

  static TextStyle title(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle description(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      color: const Color(0xFF7C849D),
    );
  }

  static TextStyle buttonText(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      color: Colors.white,
    );
  }

  static TextStyle subtitle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF7C849D),
    );
  }

  static const TextStyle greetingStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w300,
    letterSpacing: 2,
    color: AppColors.textSecondary,
  );

  static const TextStyle dashboardHeadline = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: AppColors.textPrimary,
  );

  static const TextStyle categoryLabel = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.categoryLabel,
  );

  static const TextStyle categoryLabelStyle = categoryLabel;

  static const TextStyle categoryTitleStyle = TextStyle(
    fontSize: 20,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle searchHintStyle = TextStyle(
    color: Colors.grey,
  );

  static const TextStyle inputHint = searchHintStyle;

  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle buttonText2 = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle title2 = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
    color: Colors.black,
  );

  static const TextStyle title3 = title2;

  static const TextStyle subtitle3 = TextStyle(
    fontFamily: 'Inter',
    color: Colors.grey,
  );

  static const TextStyle hint = searchHintStyle;

  static const TextStyle button = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Inter',
    color: Colors.black,
  );

  static const TextStyle link = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
  );

  static const TextStyle otpInput = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
    color: Colors.black,
  );

  static const TextStyle headerTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
