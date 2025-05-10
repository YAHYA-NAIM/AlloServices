import 'package:flutter/material.dart';
import 'package:alloservices/colors.dart';
import 'package:alloservices/typography.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../view_models/edit_profil_view_model.dart';

class EditProfilePage extends StatelessWidget {
  final editVM = Get.put(EditProfileViewModel());
  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

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
                  const SizedBox(width: 30),
                  Text(
                    AppLocalizations.of(context)!.editProfile,
                    style: AppTypography.title(18),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Obx(() {
                return Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.profilePicture,
                        backgroundImage: editVM.profileImageUrl.value.isNotEmpty
                            ? NetworkImage(editVM.profileImageUrl.value)
                            : null,
                        child: editVM.profileImageUrl.value.isEmpty
                            ? const Icon(Icons.person, size: 60, color: Colors.white)
                            : null,
                      ),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width / 2 - 60 - 10,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () => editVM.pickAndUploadImage(),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 20),

              ProfileField(label: AppLocalizations.of(context)!.firstNameHint, controller: editVM.firstNameController),
              const SizedBox(height: 20),
              ProfileField(label: AppLocalizations.of(context)!.lastNameHint, controller: editVM.lastNameController),
              const SizedBox(height: 20),
              ProfileField(label: AppLocalizations.of(context)!.email, controller: editVM.emailController),
              const SizedBox(height: 20),
              ProfileField(label: AppLocalizations.of(context)!.phoneNumber, controller: editVM.phoneController),
              const SizedBox(height: 20),
              ProfileField(label: AppLocalizations.of(context)!.address, controller: editVM.addressController),

              const Spacer(),

              SizedBox(
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
                    editVM.updateUserData();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: AppTypography.buttonText(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const ProfileField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.label(12),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.fieldBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
