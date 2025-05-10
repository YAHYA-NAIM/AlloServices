import 'package:flutter/material.dart';
import '../colors.dart';
import '../typography.dart';
import '../styles.dart';

class PersonalInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String info;

  const PersonalInfoCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.06;

    return Padding(
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

          // Label + Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.label(screenWidth * 0.045),
                ),
                const SizedBox(height: 4),
                Text(
                  info,
                  style: AppTypography.info(screenWidth * 0.038),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
