// lib/widgets/app_bottom_nav_bar.dart

import 'package:flutter/material.dart';

/// A BottomNavigationBar that stays in sync with your app’s named routes.
class AppBottomNavBar extends StatelessWidget {
  // Define your tabs once
  static const _tabs = <_NavTab>[
    _NavTab(icon: Icons.home,          label: 'Home',       route: '/home'),
    _NavTab(icon: Icons.shopping_cart, label: 'Cart',       route: '/cart'),
    _NavTab(icon: Icons.favorite,      label: 'Favourites', route: '/favourites'),
    _NavTab(icon: Icons.person,        label: 'Profile',    route: '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/home';
    final currentIndex = _tabs.indexWhere((t) => t.route == currentRoute).clamp(0, _tabs.length - 1);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: _tabs.map((t) => BottomNavigationBarItem(
        icon: Icon(t.icon),
        label: t.label,
      )).toList(),
      onTap: (idx) {
        final target = _tabs[idx].route;
        if (target != currentRoute) {
          Navigator.pushReplacementNamed(context, target);
        }
      },
    );
  }
}

class _NavTab {
  final IconData icon;
  final String label;
  final String route;
  const _NavTab({required this.icon, required this.label, required this.route});
}
