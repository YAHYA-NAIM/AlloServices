import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../styles.dart';
import '../../typography.dart';
import '../../view_models/sign_in_view_model.dart';

class SignInScreen extends StatelessWidget {
  final SignInViewModel controller = Get.put(SignInViewModel());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.08),

              Center(
                child: Image.asset(
                  'assets/logo2.png',
                  height: screenHeight * 0.1,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              Text(
                AppLocalizations.of(context)!.signInTitle,
                style: AppTypography.title(screenWidth * 0.08),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                AppLocalizations.of(context)!.signInSubtitle,
                style: AppTypography.subtitle(screenWidth * 0.045),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: screenHeight * 0.02),
              Obx(() {
                if (controller.errortext.value.isEmpty) return SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    controller.errortext.value,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
              SizedBox(height: screenHeight * 0.06),

              Container(
                padding: EdgeInsets.all(5),
                decoration: AppStyles.inputBoxDecoration,
                child: TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                    hintText: AppLocalizations.of(context)!.emailHint,
                    hintStyle: AppTypography.hint,
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              Container(
                padding: EdgeInsets.all(5),
                decoration: AppStyles.inputBoxDecoration,
                child: Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.obscureText.value,
                  decoration: InputDecoration(
                    prefixIcon:
                    Icon(Icons.lock_outline, color: AppColors.primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureText.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    hintText: AppLocalizations.of(context)!.passwordHint,
                    hintStyle: AppTypography.hint,
                    border: InputBorder.none,
                  ),
                )),
              ),

              SizedBox(height: screenHeight * 0.015),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() => Row(
                      children: [
                        Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: controller.toggleRememberMe,
                          activeColor: AppColors.primary,
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.rememberMe,
                            style: AppTypography.body.copyWith(
                              fontSize: screenWidth * 0.04,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )),
                  ),
                  TextButton(
                    onPressed: controller.goToForgotPassword,
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory),
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style:
                      AppTypography.link.copyWith(color: AppColors.accent),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              ElevatedButton(
                onPressed: () {
                  controller.signIn(context);
                },
                style: AppStyles.primaryButton,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppLocalizations.of(context)!.signInButton,
                      style: AppTypography.button,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.noAccount,
                      style: AppTypography.body.copyWith(
                          fontSize: screenWidth * 0.04),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.goToSignUp,
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory),
                    child: Text(
                      AppLocalizations.of(context)!.signUpLink,
                      style:
                      AppTypography.link.copyWith(color: AppColors.accent),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.socialLogin,
                      style: AppTypography.title3,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          controller.signInWithGoogle();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: AppStyles.socialButtonDecoration,
                          child: Image.asset('assets/google.png',
                              width: 30, height: 30),
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
    );
  }
}
