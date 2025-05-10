import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/styles.dart';
import '/colors.dart';
import '/typography.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildLabelField(String label, TextEditingController controller, {bool isPassword = false}) {
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
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.fieldRequired;
            }
            if (isPassword && label.toLowerCase().contains('new') && value.length < 6) {
              return AppLocalizations.of(context)!.passwordLengthError;
            }
            return null;
          },
        ),
      ],
    );
  }

  void _savePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.passwordMismatch)),
        );
        return;
      }

      final isCurrentPasswordCorrect = true;
      if (!isCurrentPasswordCorrect) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.currentPasswordIncorrect)),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.passwordChangedSuccess)),
      );

      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              // Header Row
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const CircleAvatar(
                      backgroundColor: AppColors.secondary,
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 12),
                   Text(
                     AppLocalizations.of(context)!.changePassword,
                    style: AppTypography.title(18),
                  ),
                ],
              ),
              const SizedBox(height: 80),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildLabelField(AppLocalizations.of(context)!.currentPassword, _currentPasswordController, isPassword: true),
                      const SizedBox(height: 20),
                      buildLabelField(AppLocalizations.of(context)!.newPassword, _newPasswordController, isPassword: true),
                      const SizedBox(height: 20),
                      buildLabelField(AppLocalizations.of(context)!.confirmPassword, _confirmPasswordController, isPassword: true),
                      const SizedBox(height: 30),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: AppStyles.onboardingButtonStyle(),
                          onPressed: _savePassword,
                          child: Text(
                            AppLocalizations.of(context)!.save,
                            style: AppTypography.buttonText(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
