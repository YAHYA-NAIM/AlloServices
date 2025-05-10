import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/services.dart';
import '../typography.dart';
import '../colors.dart';
import '../view_models/Dashboard_view_model.dart';
import '../view_models/SubCategorie_view_model.dart';

class CategorySectionCard extends StatefulWidget {
  final String title;
  final String categoryKey;

  const CategorySectionCard({
    Key? key,
    required this.title,
    required this.categoryKey,
  }) : super(key: key);

  @override
  _CategorySectionCardState createState() => _CategorySectionCardState();
}

class _CategorySectionCardState extends State<CategorySectionCard> {
  late final DashboardViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Get.find<DashboardViewModel>();

    // Initialize loading state if not already set
    if (!viewModel.loadingCategories.containsKey(widget.categoryKey)) {
      viewModel.loadingCategories[widget.categoryKey] = false;
    }

    // Trigger data loading
    _loadData();
  }

  Future<void> _loadData() async {
    // Small delay to avoid UI jank when multiple cards initialize at once
    await Future.delayed(Duration(milliseconds: 100));
    viewModel.loadCategorySubServices(widget.categoryKey);
  }

  void _navigateToSubCategories() async {
    final subCategoriesViewModel = Get.put(SubCategoriesViewModel());
    await subCategoriesViewModel.loadSubServices(widget.categoryKey);
    Get.toNamed('/subcategories');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.35;
    final itemHeight = itemWidth * 1.3;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: AppTypography.title(20),
              ),
              InkWell(
                onTap: _navigateToSubCategories,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyColor.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.seeAll,
                        style: AppTypography.dashboardHeadline.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GetBuilder<DashboardViewModel>(
          builder: (viewModel) {
            final bool isLoading = viewModel.isLoadingCategory(widget.categoryKey);
            final List<SubService> services = viewModel.getSubServicesForCategory(widget.categoryKey);


            if (isLoading) {
              return const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (services.isEmpty) {
              return SizedBox(
                height: 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.noservice,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.loadCategorySubServices(widget.categoryKey);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: Size(double.infinity, 60),
                          elevation: 4,
                        ),
                        child: Text(AppLocalizations.of(context)!.refresh,style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SizedBox(
              height: itemHeight + 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: services.length > 4 ? 4 : services.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = services[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          item.picture,
                          height: itemHeight,
                          width: itemWidth,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: itemHeight,
                              width: itemWidth,
                              color: Colors.grey.shade200,
                              child: Center(
                                child: Icon(Icons.image_not_supported, size: 40),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.name,
                        style: AppTypography.categoryLabel,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}