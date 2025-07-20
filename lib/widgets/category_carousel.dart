// lib/widgets/category_carousel.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class CategoryCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov       = context.watch<ProductProvider>();
    final cats       = prov.categories;
    final selected   = prov.selectedCategory;
    final theme      = Theme.of(context);
    final isDark     = theme.brightness == Brightness.dark;
    final bgColor    = theme.scaffoldBackgroundColor;
    final unSelColor = theme.textTheme.bodyMedium?.color;
    final selColor   = theme.colorScheme.primary;
    final selText    = theme.colorScheme.onPrimary;

    return Container(
      color: bgColor,
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final cat    = cats[i];
          final isSel  = (selected == null && cat == 'All') || (selected == cat);

          return ChoiceChip(
            label: Text(
              cat,
              style: TextStyle(
                // selected chips use onPrimary text, others body text color
                color: isSel ? selText : unSelColor,
              ),
            ),
            selected: isSel,
            onSelected: (_) => prov.selectCategory(cat),
            selectedColor: selColor,
            backgroundColor: isDark
                // slightly lighter on dark to stand out
                ? Colors.white12
                // slightly darker on light to stand out
                : Colors.black12,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          );
        },
      ),
    );
  }
}
