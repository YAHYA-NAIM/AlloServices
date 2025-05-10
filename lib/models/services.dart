import 'package:get/get.dart';
import '../../view_models/settings_view_model.dart';
class ServiceCategory {
  final String key;
  final Map<String, String> translations;
  final List<SubService> subServices;

  ServiceCategory({
    required this.key,
    required this.translations,
    required this.subServices,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    final subServicesList = json['subServices'] as List;

    return ServiceCategory(
      key: json['key'],
      translations: Map<String, String>.from(json['translations']),
      subServices: subServicesList.map((item) => SubService.fromJson(item)).toList(),
    );
  }
}

class SubService {
  final String name;         // Localized name (for display)
  final String nameEn;       // English name (for backend/email)
  final String description;
  final String picture;
  bool selected;

  SubService({
    required this.name,
    required this.nameEn,
    required this.description,
    required this.picture,
    this.selected = false,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    final translations = json['translations'];
    final languageCode = Get.find<SettingsViewModel>().selectedLanguage.value;

    String getLanguageKey(String lang) {
      switch (lang) {
        case 'العربية':
          return 'ar';
        case 'Français':
          return 'fr';
        case '中文':
          return 'zh';
        default:
          return 'eng';
      }
    }

    final langKey = getLanguageKey(languageCode);
    final localized = translations[langKey] ?? translations['eng'] ?? translations.values.first;
    final english = translations['eng'] ?? translations.values.first;

    return SubService(
      name: localized['name'] ?? 'Unknown',
      nameEn: english['name'] ?? 'Unknown',
      description: localized['description'] ?? '',
      picture: json['picture'] ?? 'assets/images/placeholder.png',
    );
  }
}
