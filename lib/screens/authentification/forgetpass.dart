import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../typography.dart';
import '../../view_models/foroget_pass_view_model.dart';

class ForgetpassScreen extends StatelessWidget {
  final ForgetPassViewModel viewModel = Get.put(ForgetPassViewModel());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(Icons.arrow_back_ios_new, size: 22),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.13),

                  // Title
                  Text(
                    AppLocalizations.of(context)!.forgotPasswordTitle,
                    style: AppTypography.title(screenWidth * 0.08),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  Text(
                    AppLocalizations.of(context)!.forgotPasswordSubtitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.subtitle(screenWidth * 0.045),
                  ),

                  SizedBox(height: screenHeight * 0.08),

                  // Email field with form validation
                  Form(
                    key: viewModel.formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.inputBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: viewModel.emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                          hintText: AppLocalizations.of(context)!.emailHint,
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                        ),
                        validator: viewModel.validateEmail,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.06),

                  // Reset Button
                  ElevatedButton(
                    onPressed: () {
                      viewModel.onResetPasswordTap(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: Size(double.infinity, 60),
                      elevation: 4,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.resetPasswordButton,
                      style: AppTypography.buttonText(screenWidth * 0.045).copyWith(
                        color: Colors.white,
                      ),
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
