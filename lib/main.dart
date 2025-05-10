import 'package:alloservices/screens/Home/HomeScreen.dart';
import 'package:alloservices/screens/Home/Settings/EditProfilePage.dart';
import 'package:alloservices/screens/Home/Settings/PersonalInfoScreen.dart';
import 'package:alloservices/screens/Home/Settings/SecurityScreen.dart';
import 'package:alloservices/screens/Home/SubCategoriesScreen.dart';
import 'package:alloservices/screens/authentification/SignInScreen.dart';
import 'package:alloservices/screens/authentification/SignUpScreen.dart';
import 'package:alloservices/screens/authentification/forgetpass.dart';
import 'package:alloservices/screens/onboarding_screen.dart';
import 'package:alloservices/view_models/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'Repository/mail_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(SettingsViewModel());
  Get.put(EmailRepository());
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final prefs = await SharedPreferences.getInstance();

  // Onboarding logic
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
  }

  // Remember Me logic
  bool isRemembered = prefs.getBool('isRemembered') ?? false;
  final user = FirebaseAuth.instance.currentUser;
  bool isLoggedIn = isRemembered && user != null && user.emailVerified;

  // Decide initial route
  String initialRoute = isFirstTime
      ? '/onboarding'
      : isLoggedIn
      ? '/home'
      : '/signin';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('zh'),
      ],
      locale: _getLocaleFromPreferences(),
      getPages: [
        GetPage(name: '/onboarding', page: () => OnBoardingScreen()),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/forgot', page: () => ForgetpassScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/personalInfo', page: () => PersonalInfoScreen()),
        GetPage(name: '/editProfile', page: () => EditProfilePage()),
        GetPage(name: '/security', page: () => ChangePasswordScreen()),
        GetPage(name: '/subcategories', page: () => SubCategoriesScreen()),
      ],
    );
  }

  Locale _getLocaleFromPreferences() {
    final lang = Get.find<SettingsViewModel>().selectedLanguage.value;
    if (lang == 'العربية') return const Locale('ar');
    if (lang == 'Français') return const Locale('fr');
    if (lang == '中文') return const Locale('zh');
    return const Locale('en');
  }
}
