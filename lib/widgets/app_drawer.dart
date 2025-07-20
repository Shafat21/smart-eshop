// lib/widgets/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth         = Provider.of<AuthProvider>(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final realName     = auth.name ?? 'Guest';
    final username     = auth.username != null ? '@${auth.username}' : '';

    final theme    = Theme.of(context);
    final isDark   = theme.brightness == Brightness.dark;
    // choose contrast‐aware defaults
    final defaultIconColor = isDark ? Colors.white70 : Colors.grey[700]!;
    final defaultTextColor = isDark ? Colors.white70 : Colors.black87;

    final items = [
      {'label': 'Home',       'icon': Icons.home,          'route': '/home'},
      {'label': 'Cart',       'icon': Icons.shopping_cart, 'route': '/cart'},
      {'label': 'Favourites', 'icon': Icons.favorite,      'route': '/favourites'},
      {'label': 'Profile',    'icon': Icons.person,        'route': '/profile'},
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: theme.primaryColor,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Text(
                      realName[0].toUpperCase(),
                      style: TextStyle(fontSize: 24, color: theme.primaryColor),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        realName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (username.isNotEmpty) ...[
                        SizedBox(height: 4),
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // menu items
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final item       = items[i];
                  final isSelected = item['route'] == currentRoute;
                  final highlight  = theme.colorScheme.secondary.withOpacity(0.1);

                  final iconColor = isSelected
                      ? theme.colorScheme.secondary
                      : defaultIconColor;
                  final textColor = isSelected
                      ? theme.colorScheme.secondary
                      : defaultTextColor;

                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      final route = item['route'] as String;
                      if (route != currentRoute) {
                        Navigator.pushReplacementNamed(context, route);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? highlight : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      child: Row(
                        children: [
                          Icon(item['icon'] as IconData, color: iconColor),
                          SizedBox(width: 16),
                          Text(
                            item['label'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Divider(color: theme.dividerColor, thickness: 1),

            // logout
            InkWell(
              onTap: () {
                auth.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: defaultIconColor),
                    SizedBox(width: 16),
                    Text(
                      'Log out',
                      style: TextStyle(fontSize: 16, color: defaultTextColor),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // bottom logo
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 80,
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
