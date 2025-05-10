import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../typography.dart';
import '../../view_models/SubCategorie_view_model.dart';
import '../../widgets/SubCategoriesCard.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<SubCategoriesViewModel>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          const SizedBox(height: 60),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFF5F6FA),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.subcategories,
                style: AppTypography.title(32),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Obx(() {
              if (viewModel.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.subServices.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.nocategoryfound),
                );
              }

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      for (var sub in viewModel.subServices) ...[
                        CustomCheckCard(
                          imageUrl: sub.picture,
                          title: sub.name,
                          description: sub.description,
                          onChanged: (isSelected) {
                            viewModel.toggleSubService(sub);
                          },
                        ),
                        if (sub != viewModel.subServices.last)
                          const Divider(color: Colors.grey, thickness: 1),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  viewModel.submitOrder(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.orderNow,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

