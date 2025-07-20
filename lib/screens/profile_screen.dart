// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth      = context.watch<AuthProvider>();
    final themeProv = context.watch<ThemeProvider>();
    final theme     = Theme.of(context);
    final titleStyle    = theme.textTheme.titleMedium;
    final subtitleStyle = theme.textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: Icon(Icons.person, color: theme.iconTheme.color),
              title: Text('Name', style: titleStyle),
              subtitle: Text(auth.name ?? '—', style: subtitleStyle),
            ),
            ListTile(
              leading: Icon(Icons.alternate_email, color: theme.iconTheme.color),
              title: Text('Username', style: titleStyle),
              subtitle: Text(auth.username ?? '—', style: subtitleStyle),
            ),
            ListTile(
              leading: Icon(Icons.email, color: theme.iconTheme.color),
              title: Text('Email', style: titleStyle),
              subtitle: Text(auth.email ?? '—', style: subtitleStyle),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: theme.iconTheme.color),
              title: Text('Phone', style: titleStyle),
              subtitle: Text(auth.phone ?? '—', style: subtitleStyle),
            ),
            ListTile(
              leading: Icon(Icons.home, color: theme.iconTheme.color),
              title: Text('Address', style: titleStyle),
              subtitle: Text(auth.address ?? '—', style: subtitleStyle),
            ),

            Divider(height: 32),

            SwitchListTile(
              title: Text('Dark Mode', style: titleStyle),
              secondary: Icon(
                themeProv.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: theme.iconTheme.color,
              ),
              value: themeProv.isDarkMode,
              onChanged: (_) => themeProv.toggleTheme(),
            ),

            Spacer(),

            ElevatedButton.icon(
              onPressed: () {
                auth.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
