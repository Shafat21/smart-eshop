import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () => _showFilterSheet(context),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterSheet(),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  @override
  __FilterSheetState createState() => __FilterSheetState();
}

class __FilterSheetState extends State<_FilterSheet> {
  int _sortOption = 0;
  double _maxPrice = double.infinity;
  final _sortLabels = [
    'Price: Low → High',
    'Price: High → Low',
    'Rating: Low → High',
    'Rating: High → Low',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.8,
      minChildSize: 0.3,
      builder: (ctx, scrollCtl) => Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          controller: scrollCtl,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => setState(() {
                    _sortOption = 0;
                    _maxPrice   = double.infinity;
                  }),
                  child: Text('Clear'),
                ),
                Text('Filters', style: theme.textTheme.titleLarge),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Sort by
            Text('Sort by', style: theme.textTheme.titleMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(_sortLabels.length, (i) {
                return ChoiceChip(
                  label: Text(
                    _sortLabels[i],
                    style: TextStyle(
                      color: _sortOption == i
                          ? theme.colorScheme.onPrimary
                          : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  selected: _sortOption == i,
                  selectedColor: theme.colorScheme.primary,
                  backgroundColor: theme.chipTheme.backgroundColor,
                  onSelected: (_) => setState(() => _sortOption = i),
                );
              }),
            ),
            SizedBox(height: 24),

            // Max Price
            Text('Max Price', style: theme.textTheme.titleMedium),
            Slider(
              value: _maxPrice.isInfinite ? 500 : _maxPrice.clamp(0, 500),
              min: 0,
              max: 500,
              divisions: 5,
              label: _maxPrice.isInfinite ? '∞' : '\$${_maxPrice.round()}',
              onChanged: (v) => setState(() => _maxPrice = v),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$0'),
                Text(_maxPrice.isInfinite ? '∞' : '\$${_maxPrice.round()}'),
                Text('\$500'),
              ],
            ),
            SizedBox(height: 32),

            // Apply
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final prov = context.read<ProductProvider>();
                  prov.sort(SortOption.values[_sortOption]);
                  prov.setMaxPriceFilter(
                    _maxPrice.isInfinite ? double.infinity : _maxPrice,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  'Apply Filter',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
