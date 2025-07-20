// lib/widgets/badge_icon.dart

import 'package:flutter/material.dart';
// alias the package so it doesn’t clash with Material’s Badge
import 'package:badges/badges.dart' as badges;

class BadgeIcon extends StatelessWidget {
  final IconData icon;
  final int badgeCount;
  final VoidCallback onTap;

  const BadgeIcon({
    Key? key,
    required this.icon,
    required this.badgeCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: badges.Badge(
        showBadge: badgeCount > 0,
        badgeContent: Text(
          '$badgeCount',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        // you can customize position if you like:
        // position: badges.BadgePosition.topEnd(top: -5, end: -5),
        child: Icon(icon),
      ),
    );
  }
}
