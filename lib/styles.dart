import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  static BoxDecoration roundedIconContainer(double size) {
    return BoxDecoration(
      color: AppColors.secondary,
      shape: BoxShape.circle,
    );
  }

  static ButtonStyle onboardingButtonStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );
  }

  static ButtonStyle onboardingCircleButtonStyle() {
    return ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16),
    );
  }

  static BoxDecoration categoryCardDecoration(Color bgColor) {
    return BoxDecoration(
      color: bgColor,
      shape: BoxShape.circle,
    );
  }

  static ButtonStyle editButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }

  static final BoxDecoration inputDecoration = BoxDecoration(
    color: AppColors.secondary,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: AppColors.greyColor.withOpacity(0.2),
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );

  static final BoxDecoration inputBoxDecoration = inputDecoration;

  static final BoxDecoration socialButtonDecoration = BoxDecoration(
    color: const Color(0xFFFCFCFC),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.border),
  );

  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    minimumSize: const Size(double.infinity, 66),
  );

  static Widget socialIcon({required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }

  static Widget socialImage(String path) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Image.asset(path, width: 30, height: 30),
    );
  }
}
