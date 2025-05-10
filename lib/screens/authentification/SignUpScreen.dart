import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../view_models/sign_up_view_model.dart';
import '/typography.dart';
import '/colors.dart';
import '/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignUpScreen extends StatelessWidget {
  final SignUpViewModel controller = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.08),

                // Logo
                Center(
                  child: Image.asset(
                    'assets/logo2.png',
                    height: screenHeight * 0.1,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Title
                Text(
                  AppLocalizations.of(context)!.signUpTitle,
                  style: AppTypography.title2.copyWith(fontSize: screenWidth * 0.08),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  AppLocalizations.of(context)!.signUpSubtitle,
                  style: AppTypography.subtitle2.copyWith(fontSize: screenWidth * 0.045),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: screenHeight * 0.03),

                // First name and last name
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: AppStyles.inputDecoration,
                        child: TextField(
                          controller: controller.firstNameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline, color: AppColors.iconColor),
                            hintText: AppLocalizations.of(context)!.firstNameHint,
                            hintStyle: AppTypography.inputHint,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: AppStyles.inputDecoration,
                        child: TextField(
                          controller: controller.lastNameController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.lastNameHint,
                            hintStyle: AppTypography.inputHint,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),

                // Email
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: AppStyles.inputDecoration,
                  child: TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.iconColor),
                      hintText: AppLocalizations.of(context)!.emailHint,
                      hintStyle: AppTypography.inputHint,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Phone number
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: AppStyles.inputDecoration,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: SizedBox(
                          height: 55,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                errorStyle: TextStyle(height: 0, fontSize: 0),
                              ),
                            ),
                            child: IntlPhoneField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.phoneHint,
                                hintStyle: AppTypography.inputHint,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              initialCountryCode: 'MA',
                              disableLengthCheck: true,
                              onChanged: (phone) {
                                controller.phoneNumber.value = phone.completeNumber;
                                controller.countryCode.value = phone.countryCode;
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        child: Icon(Icons.phone_android_outlined, color: AppColors.iconColor),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Password
                Obx(() => Container(
                  padding: EdgeInsets.all(5),
                  decoration: AppStyles.inputDecoration,
                  child: TextField(
                    controller: controller.passwordController,
                    obscureText: controller.obscurePassword.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.iconColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      hintText: AppLocalizations.of(context)!.passwordHint,
                      hintStyle: AppTypography.inputHint,
                      border: InputBorder.none,
                    ),
                  ),
                )),

                SizedBox(height: screenHeight * 0.02),

                // Confirm Password
                Obx(() => Container(
                  padding: EdgeInsets.all(5),
                  decoration: AppStyles.inputDecoration,
                  child: TextField(
                    controller: controller.confirmPasswordController,
                    obscureText: controller.obscurePassword.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.iconColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                      hintStyle: AppTypography.inputHint,
                      border: InputBorder.none,
                    ),
                  ),
                )),

                SizedBox(height: screenHeight * 0.015),

                // Sign Up Button
                ElevatedButton(
                  onPressed: controller.signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(double.infinity, 66),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
                      style: AppTypography.buttonText2,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.goToSignIn,
                      child: Text(
                        AppLocalizations.of(context)!.loginText,
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.03),

                // Social media sign-up
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.socialSignUp,
                      style: AppTypography.headerTitle,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            controller.signUpWithGoogle();
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: AppStyles.socialButtonDecoration,
                            child: Image.asset('assets/google.png', width: 30, height: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
