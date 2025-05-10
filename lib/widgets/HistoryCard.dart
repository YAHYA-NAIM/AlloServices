import 'package:flutter/material.dart';
import '/typography.dart';

class HistoryCard extends StatelessWidget {
  final String categoryName;
  final List<String> subCategories;
  final String date;

  const HistoryCard({
    super.key,
    required this.categoryName,
    required this.subCategories,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Grey box with history icon
            Container(
              height: 154,
              width: 139,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Icon(
                  Icons.history,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Right section with text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: AppTypography.title(18),
                  ),
                  const SizedBox(height: 4),
                  ...subCategories.map((subCategory) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        subCategory,
                        style: AppTypography.info(16),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 12),
                  Text(
                    date,
                    style: AppTypography.info(14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
