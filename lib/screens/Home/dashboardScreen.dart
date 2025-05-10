import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../colors.dart';
import '../../typography.dart';
import '../../view_models/Dashboard_view_model.dart';
import '../../view_models/SubCategorie_view_model.dart';
import '../../widgets/CategoriesHomeCard.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onSeeAllTap;

  const DashboardScreen({Key? key, required this.onSeeAllTap}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardViewModel viewModel;
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, String>> categories;

  @override
  void initState() {
    super.initState();
    viewModel = Get.put(DashboardViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocalizedCategories();
    });

    _searchController.addListener(() {
      viewModel.updateSearchQuery(_searchController.text);
    });
  }

  void _initializeLocalizedCategories() {
    categories = [
      {"title": AppLocalizations.of(context)!.categoryCleaning, "key": "categoryCleaning"},
      {"title": AppLocalizations.of(context)!.categoryJardinage, "key": "categoryJardinage"},
      {"title": AppLocalizations.of(context)!.categoryClim, "key": "categoryClimatisation"},
      {"title": AppLocalizations.of(context)!.categorySurveillance, "key": "categorySurveillance"},
      {"title": AppLocalizations.of(context)!.categoryGardiennage, "key": "categoryGardiennage"},
      {"title": AppLocalizations.of(context)!.categoryElectric, "key": "categoryElectricity"},
      {"title": AppLocalizations.of(context)!.categoryComptabilite, "key": "categoryComptabilite"},
      {"title": AppLocalizations.of(context)!.categoryAntiNuisible, "key": "categoryAntiNuisible"},
      {"title": AppLocalizations.of(context)!.categorySerrurier, "key": "categorySerrurier"},
      {"title": AppLocalizations.of(context)!.categoryDeratisation, "key": "categoryDeratisation"},
    ];

    viewModel.setCategories(categories);

    final keys = categories.map((cat) => cat['key']!).toList();
    _initializeAllCategories(keys);

    _preloadVisibleCategories();
  }

  void _initializeAllCategories(List<String> categoryKeys) {
    for (String key in categoryKeys) {
      viewModel.loadingCategories[key] ??= false;
      viewModel.categorySubServices[key] ??= [];
    }
    viewModel.update();
  }

  void _preloadVisibleCategories() {
    viewModel.loadCategorySubServices("categoryCleaning");
    viewModel.loadCategorySubServices("categoryElectricity");
    viewModel.loadCategorySubServices("categoryClimatisation");
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Obx(() => Text(
                    AppLocalizations.of(context)!.greetingUser(viewModel.firstName.value),
                    style: AppTypography.greetingStyle,
                  )),
                  Text(
                    AppLocalizations.of(context)!.whatLookingFor,
                    style: AppTypography.dashboardHeadline.copyWith(
                      fontSize: screenWidth * 0.08,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSearchBar(),
                ],
              ),
            ),
            Obx(() => viewModel.isSearching.value
                ? _buildSearchResults()
                : _buildDefaultContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultContent() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(16),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildCategoryCard(
                imagePath: 'assets/icons/cleaning.png',
                label: AppLocalizations.of(context)!.categoryCleaning,
                bgColor: AppColors.categoryCleaning,
                categoryKey: "categoryCleaning",
                onTap: () => _navigateToSubCategories("categoryCleaning"),
              ),
              _buildCategoryCard(
                imagePath: 'assets/icons/climatisation.png',
                label: AppLocalizations.of(context)!.categoryClim,
                bgColor: AppColors.categoryClimatisation,
                categoryKey: "categoryClimatisation",
                onTap: () => _navigateToSubCategories("categoryClimatisation"),
              ),
              _buildCategoryCard(
                imagePath: 'assets/icons/electrecity.png',
                label: AppLocalizations.of(context)!.categoryElectric,
                bgColor: AppColors.categoryElectricite,
                categoryKey: "categoryElectricite",
                onTap: () => _navigateToSubCategories("categoryElectricity"),
              ),
              _buildCategoryCard(
                imagePath: 'assets/icons/arrow.png',
                label: AppLocalizations.of(context)!.seeAll,
                bgColor: AppColors.categoryGrey,
                isSeeAll: true,
                onTap: widget.onSeeAllTap,
              ),
            ],
          ),
        ),
        Column(
          children: [
            for (var i = 0; i < categories.length; i++) ...[
              _buildCategorySectionCard(
                title: categories[i]['title']!,
                categoryKey: categories[i]['key']!,
              ),
              if (i < categories.length - 1) const SizedBox(height: 16),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (viewModel.filteredCategories.isEmpty) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.nocategoryfound,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              AppLocalizations.of(context)!.searchresult,
              style: AppTypography.dashboardHeadline.copyWith(fontSize: 20),
            ),
          ),
          Column(
            children: [
              for (var i = 0; i < viewModel.filteredCategories.length; i++) ...[
                _buildCategorySectionCard(
                  title: viewModel.filteredCategories[i]['title']!,
                  categoryKey: viewModel.filteredCategories[i]['key']!,
                ),
                if (i < viewModel.filteredCategories.length - 1) const SizedBox(height: 16),
              ],
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                _searchController.clear();
                viewModel.resetSearch();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.back,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.searchBackground,
        border: Border.all(color: AppColors.searchBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchHint,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onSubmitted: (_) => viewModel.performSearch(),
            ),
          ),
          GestureDetector(
            onTap: viewModel.performSearch,
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.search, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSubCategories(String categoryKey) async {
    final subCategoriesViewModel = Get.put(SubCategoriesViewModel());
    await subCategoriesViewModel.loadSubServices(categoryKey);
    Get.toNamed('/subcategories');
  }

  Widget _buildCategorySectionCard({required String title, required String categoryKey}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: CategorySectionCard(title: title, categoryKey: categoryKey),
    );
  }

  Widget _buildCategoryCard({
    required String imagePath,
    required String label,
    required Color bgColor,
    String categoryKey = "",
    bool isSeeAll = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              imagePath,
              height: 27,
              width: 27,
              color: isSeeAll ? Colors.grey : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.categoryLabel,
          ),
        ],
      ),
    );
  }
}
