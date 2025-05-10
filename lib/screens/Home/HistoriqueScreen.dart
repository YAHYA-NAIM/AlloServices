import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_models/historique_view_model.dart';
import '../../widgets/HistoryCard.dart';

class HistoriqueScreen extends StatelessWidget {
  HistoriqueScreen({super.key});
  final HistoryViewModel viewModel = Get.put(HistoryViewModel());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              child: Text(
                AppLocalizations.of(context)!.historyLabel,
                style: TextStyle(
                  fontSize: screenWidth * 0.075,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (viewModel.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.historyItems.isEmpty) {
                  return Center(child: Text(AppLocalizations.of(context)!.nohistory));
                }

                return ListView.builder(
                  itemCount: viewModel.historyItems.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.historyItems[index];
                    return HistoryCard(
                      categoryName: item.categoryName,
                      subCategories: item.subCategories,
                      date: item.date,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
