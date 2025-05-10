import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../styles.dart';
import '../../typography.dart';
import '../../view_models/SubCategorie_view_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Initialize categories inside the build method where context is available
    final List<Category> categories = [
      Category(
        AppLocalizations.of(context)!.categoryCleaning,
        "assets/icons/cleaning.png",
        AppColors.categoryCleaning,
        "categoryCleaning",
      ),
      Category(
        AppLocalizations.of(context)!.categoryClim,
        "assets/icons/climatisation.png",
        AppColors.categoryClimatisation,
        "categoryClimatisation",
      ),
      Category(
        AppLocalizations.of(context)!.categoryAntiNuisible,
        "assets/icons/antinuisible.png",
        AppColors.categoryAntiNuisible,
        "categoryAntiNuisible",
      ),
      Category(
        AppLocalizations.of(context)!.categoryElectric,
        "assets/icons/electrecity.png",
        AppColors.categoryElectricite,
        "categoryElectricite",
      ),
      Category(
        AppLocalizations.of(context)!.categoryJardinage,
        "assets/icons/garden.png",
        AppColors.categoryJardinage,
        "categoryJardinage",
      ),
      Category(
        AppLocalizations.of(context)!.categorySerrurier,
        "assets/icons/locksmith.png",
        AppColors.categorySerrurier,
        "categorySerrurier",
      ),
      Category(
        AppLocalizations.of(context)!.categorySurveillance,
        "assets/icons/surveillance.png",
        AppColors.categorySurveillance,
        "categorySurveillance",
      ),
      Category(
        AppLocalizations.of(context)!.categoryGardiennage,
        "assets/icons/guard.png",
        AppColors.categoryGardiennage,
        "categoryGardiennage",
      ),
      Category(
        AppLocalizations.of(context)!.categoryComptabilite,
        "assets/icons/comptabilite.png",
        AppColors.categoryComptabilite,
        "categoryComptabilite",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.allCategories,
                          style: AppTypography.title(25),
                        ),
                        const SizedBox(height: 40),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categories.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenWidth < 600 ? 3 : 4,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return _buildCategoryCard(
                              imagePath: category.iconPath,
                              label: category.label,
                              bgColor: category.bgColor,
                              onTap: () async {
                                final viewModel = Get.put(SubCategoriesViewModel());
                                await viewModel.loadSubServices(category.key);
                                Get.toNamed('/subcategories');
                              },
                            );
                          },
                        ),
                      ],
                    ),
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

Widget _buildCategoryCard({
  required String imagePath,
  required String label,
  required Color bgColor,
  bool isSeeAll = false,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppStyles.categoryCardDecoration(bgColor),
          child: Image.asset(
            imagePath,
            height: 30,
            width: 30,
            color: isSeeAll ? Colors.grey : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.categoryLabelStyle,
        ),
      ],
    ),
  );
}

class Category {
  final String label;
  final String iconPath;
  final Color bgColor;
  final String key;

  Category(this.label, this.iconPath, this.bgColor, this.key);
}
