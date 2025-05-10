import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/settings_view_model.dart';
import '../../colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../typography.dart';

import '../../widgets/SettingsOptionCard.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsViewModel _settingsVM = Get.put(SettingsViewModel());

  @override
  void initState() {
    super.initState();
    _settingsVM.loadUserInfoFromFirestore(); // Load user profile info
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarSize = screenWidth * 0.22;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            // Title
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context)!.settingsOption,
                style: AppTypography.title(screenWidth * 0.075),
              ),
            ),
            const SizedBox(height: 20),
            // Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Obx(() {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(avatarSize / 2),
                    child: _settingsVM.profileImageUrl.value.isNotEmpty
                    ? Image.network(
                    _settingsVM.profileImageUrl.value,
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
                  Expanded(
                    child: Obx(() {
                      return Text(
                        _settingsVM.fullName.value,
                        style: AppTypography.label(screenWidth * 0.055).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Settings Sections
            _buildSettingsSection(
              context,
              options: [
                SettingsOptionItem(
                  icon: Icons.person_outline,
                  label: AppLocalizations.of(context)!.personalInfoLabel,
                  onTap: () {
                    Get.toNamed('/personalInfo');
                  },
                ),
                SettingsOptionItem(
                  icon: Icons.lock_outline,
                  label: AppLocalizations.of(context)!.securityLabel,
                  onTap: () {
                    Get.toNamed('/security');
                  },
                ),
              ],
            ),
            _buildSettingsSection(
              context,
              options: [
                SettingsOptionItem(
                  icon: Icons.public_outlined,
                  label: AppLocalizations.of(context)!.languageLabel,
                  onTap: _openLanguageDialog,
                  child: Obx(() {
                    return Text(
                      _settingsVM.selectedLanguage.value,
                      style: AppTypography.subtitle(14),
                    );
                  }),
                ),
                SettingsOptionItem(
                  icon: Icons.nightlight_round,
                  label: AppLocalizations.of(context)!.darkModeLabel,
                  onTap: () {
                    setState(() {
                      _settingsVM.isDarkMode.value = !_settingsVM.isDarkMode.value;
                      _settingsVM.updateUserPreferences();
                    });
                  },
                  child: Obx(() {
                    return Switch(
                      value: _settingsVM.isDarkMode.value,
                      onChanged: (value) {
                        setState(() {
                          _settingsVM.isDarkMode.value = value;
                          _settingsVM.updateUserPreferences();
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
            _buildSettingsSection(
              context,
              options: [
                SettingsOptionItem(icon: Icons.help_outline, label: AppLocalizations.of(context)!.helpSupportLabel, onTap: () {_settingsVM.showSupportFormDialog(context);}),
                SettingsOptionItem(icon: Icons.info_outline_rounded, label: AppLocalizations.of(context)!.aboutLabel, onTap: () {}),
              ],
            ),
            _buildSettingsSection(
              context,
              options: [
                SettingsOptionItem(
                  icon: Icons.logout_rounded,
                  label: AppLocalizations.of(context)!.logoutLabel,
                  onTap: () async {
                    await _settingsVM.logout(); // Call logout method
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, {required List<Widget> options}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: options),
    );
  }

  void _openLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectLanguage, style: AppTypography.title(18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption('English'),
              _languageOption('العربية'),
              _languageOption('Français'),
              _languageOption('中文'),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(String language) {
    return ListTile(
      title: Text(language, style: AppTypography.label(16)),
      onTap: () {
        setState(() {
          _settingsVM.selectedLanguage.value = language;
          _settingsVM.updateUserPreferences();
        });
        Navigator.of(context).pop();
      },
    );
  }
}
