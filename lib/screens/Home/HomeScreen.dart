import 'package:alloservices/screens/Home/CategoriesScreen.dart';
import 'package:alloservices/screens/Home/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'HistoriqueScreen.dart';
import 'dashboardScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardScreen(onSeeAllTap: navigateToCategories),
      CategoriesScreen(),
      HistoriqueScreen(),
      SettingsScreen(),
    ];
  }
  void navigateToCategories() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
            gap: 8,
            padding: const EdgeInsets.all(16),
            backgroundColor: AppColors.white,
            activeColor: AppColors.primary,
            color: Colors.grey,
            tabBackgroundColor: AppColors.primary.withOpacity(0.1),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs:  [
              GButton(icon: Icons.home_outlined, text: AppLocalizations.of(context)!.homeLabel),
              GButton(icon: Icons.category_outlined, text: AppLocalizations.of(context)!.categoriesLabel),
              GButton(icon: Icons.assignment_outlined, text: AppLocalizations.of(context)!.historyLabel),
              GButton(icon: Icons.settings_outlined, text: AppLocalizations.of(context)!.settingsOption),
            ],
          ),
        ),
      ),
    );
  }
}
