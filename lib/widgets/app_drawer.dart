// lib/widgets/app_drawer.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth      = Provider.of<AuthProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme     = Theme.of(context);
    final isDark    = themeProv.isDarkMode;
    final userName  = auth.name ?? 'Guest';
    final userTag   = auth.username != null ? '@${auth.username}' : '';
    final current   = ModalRoute.of(context)?.settings.name;
    final baseColor = theme.iconTheme.color ?? (isDark ? Colors.white70 : Colors.grey[800]!);

    final items = [
      {'label': 'Home','icon': Icons.home,'route': '/home'},
      {'label': 'Cart','icon': Icons.shopping_cart,'route': '/cart'},
      {'label': 'Favourites','icon': Icons.favorite,'route': '/favourites'},
      {'label': 'Profile','icon': Icons.person,'route': '/profile'},
    ];

    Widget buildMenuItem(Map item, int idx) {
      final selected = item['route'] == current;
      final color    = selected ? theme.colorScheme.secondary : baseColor;
      return FadeTransition(
        opacity: _fadeIn,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Material(
            color: selected ? color.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                final route = item['route'] as String;
                if (route != current) Navigator.pushReplacementNamed(context, route);
                else Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(item['icon'] as IconData, color: color, size: 24),
                    SizedBox(width: 20),
                    Text(
                      item['label'] as String,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Drawer(
      child: Column(
        children: [
          // Glassmorphic header
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/drawer_bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: 200,
                    color: theme.cardColor.withOpacity(0.4),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: FadeTransition(
                    opacity: _fadeIn,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: theme.colorScheme.secondary,
                          child: Text(
                            userName.isNotEmpty ? userName[0].toUpperCase() : 'G',
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: theme.textTheme.bodyLarge?.color)),
                              if (userTag.isNotEmpty)
                                Text(userTag,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: theme.textTheme.bodySmall?.color)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: baseColor),
                          onPressed: () {/* TODO: edit profile */},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Animated menu items
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (_, i) => buildMenuItem(items[i], i),
            ),
          ),

          // Dark mode toggle as pill
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FadeTransition(
              opacity: _fadeIn,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Row(
                  children: [
                    Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: baseColor),
                    SizedBox(width: 12),
                    Expanded(child: Text('Dark Mode')),
                    Switch(value: isDark, onChanged: (_) => themeProv.toggleTheme()),
                  ],
                ),
              ),
            ),
          ),

          // Logout with fade
          FadeTransition(
            opacity: _fadeIn,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    auth.logout();
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: baseColor),
                        SizedBox(width: 16),
                        Text('Log out', style: TextStyle(fontSize: 16, color: baseColor)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16),
          FadeTransition(
            opacity: _fadeIn,
            child: Image.asset('assets/images/logo.png', width: 80, height: 80),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
