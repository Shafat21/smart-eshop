// lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/app_drawer.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProv = context.watch<CartProvider>();
    final items    = cartProv.items;
    final theme    = Theme.of(context);

    // Group duplicates → quantity
    final qtyMap = <int, int>{};
    for (var p in items) {
      qtyMap[p.id] = (qtyMap[p.id] ?? 0) + 1;
    }
    final grouped = qtyMap.entries.map((e) {
      final prod = items.firstWhere((p) => p.id == e.key);
      return {'product': prod, 'qty': e.value};
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      drawer: AppDrawer(),
      body: items.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: theme.textTheme.bodyLarge,
              ),
            )
          : Column(
              children: [
                // Cart items list
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: grouped.length,
                    itemBuilder: (ctx, i) {
                      final entry = grouped[i];
                      final p     = entry['product'] as dynamic;
                      final qty   = entry['qty'] as int;

                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.dividerColor),
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadowColor.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Product image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                p.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),

                            // Title & Price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '\$${p.price.toStringAsFixed(2)}',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),

                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.dividerColor),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, size: 20),
                                    color: theme.iconTheme.color,
                                    onPressed: () => cartProv.remove(p),
                                  ),
                                  Text(
                                    '$qty',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 20),
                                    color: theme.iconTheme.color,
                                    onPressed: () => cartProv.add(p),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Subtotal display
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal:', style: theme.textTheme.titleMedium),
                      Text('\$${cartProv.total.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium),
                    ],
                  ),
                ),

                // Checkout button navigates to /checkout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/checkout');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        foregroundColor: theme.colorScheme.onSecondary,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        'Checkout',
                        style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            ),
    );
  }
}
