import 'package:flutter/material.dart';
import '/colors.dart';
import '/typography.dart';
import '/styles.dart';


class SettingsOptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? child;

  const SettingsOptionItem({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.06;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Rounded Icon
            Container(
              height: screenWidth * 0.13,
              width: screenWidth * 0.13,
              decoration: AppStyles.roundedIconContainer(screenWidth * 0.13),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: iconSize,
              ),
            ),
            const SizedBox(width: 16),

            // Label
            Expanded(
              child: Text(
                label,
                style: AppTypography.label(screenWidth * 0.045),
              ),
            ),
            // If there is a child widget (like Switch or Text), show it
            if (child != null) child! else const Icon(
              Icons.chevron_right,
              color: AppColors.iconInactive,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
