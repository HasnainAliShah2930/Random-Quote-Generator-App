import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../widgets/app_bottom_nav.dart';
import 'home/home_screen.dart';
import 'favorites/favorites_screen.dart';
import 'categories/categories_screen.dart';
import 'settings/settings_screen.dart';

/// Hosts the 4 main tabs behind a bottom navigation bar. Uses [IndexedStack]
/// so each tab's screen (and its scoped Bloc) stays alive when switching
/// tabs, instead of being rebuilt from scratch every time.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            // Reload favorites when switching to the favorites tab
            context.read<FavoritesBloc>().add(const FavoritesLoadRequested());
          }
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
