import 'package:alloservices/widgets/PersonalInfoCard.dart';
import 'package:flutter/material.dart';
import 'package:alloservices/colors.dart';
import 'package:alloservices/typography.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../view_models/Info_View_model.dart';

class PersonalInfoScreen extends StatelessWidget {
  final infoVM = Get.put(PersonalInfoViewModel());

  @override
  Widget build(BuildContext context) {
    infoVM.loadUserInfoFromFirestore();
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarSize = screenWidth * 0.22;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header Row
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFFF5F6FA),
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.personalInfo,
                    style: AppTypography.title(18),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/editProfile');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.edit,
                      style: AppTypography.info(16).copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Obx(() {
                  final imageUrl = infoVM.profileImageUrl.value;
                  return ClipRRect(
                  borderRadius: BorderRadius.circular(avatarSize / 2),
                  child: imageUrl.isNotEmpty
                  ? Image.network(
                  imageUrl,
                  height: avatarSize,
                  width: avatarSize,
                  fit: BoxFit.cover,
                  )
                      : Container(
                  height: avatarSize,
                  width: avatarSize,
                  color: AppColors.profilePicture,
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  );
                  }),
                  SizedBox(width: screenWidth * 0.07),

                  // Full name
                  Expanded(
                    child: Obx(() {
                      return Text(
                        infoVM.fullName.value,
                        style: AppTypography.title(screenWidth * 0.055).copyWith(color: AppColors.textPrimary),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildSettingsSection(
                context,
                options: [
                  Obx(() {
                    return PersonalInfoCard(
                      icon: Icons.person_outline,
                      label: AppLocalizations.of(context)!.fullName,
                      info: infoVM.fullName.value,
                    );
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return PersonalInfoCard(
                      icon: Icons.email_outlined,
                      label: AppLocalizations.of(context)!.email,
                      info: infoVM.email.value,
                    );
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return PersonalInfoCard(
                      icon: Icons.phone_android_outlined,
                      label: AppLocalizations.of(context)!.phoneNumber,
                      info: infoVM.phone.value,
                    );
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return PersonalInfoCard(
                      icon: Icons.location_on_outlined,
                      label: AppLocalizations.of(context)!.address,
                      info: infoVM.address.value,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget _buildSettingsSection(BuildContext context, {required List<Widget> options}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(children: options),
  );
}
