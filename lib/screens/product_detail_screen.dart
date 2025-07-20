// lib/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColor = 0;
  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    final theme   = Theme.of(context);
    final p       = ModalRoute.of(context)!.settings.arguments as Product;
    final prodProv= context.watch<ProductProvider>();
    final isFav   = prodProv.isFavourite(p.id.toString());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // --- Image with back & fav but NO blur overlay ---
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.network(p.image, fit: BoxFit.cover),
              ),
              // Back button
              Positioned(
                left: 16,
                top: MediaQuery.of(context).padding.top + 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              // Favorite button
              Positioned(
                right: 16,
                top: MediaQuery.of(context).padding.top + 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.black87,
                    ),
                    onPressed: () {
                      prodProv.toggleFavourite(p.id.toString());
                    },
                  ),
                ),
              ),
            ],
          ),

          // --- Details card below ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              p.title,
                              style: theme.textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            '\$${p.price.toStringAsFixed(0)}',
                            style: theme.textTheme.headlineSmall
                                ?.copyWith(color: theme.colorScheme.primary),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Description
                      Text(
                        p.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 24),

                      // Color selector
                      Text('Colors',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8),
                      Row(
                        children: List.generate(_colors.length, (i) {
                          final c = _colors[i];
                          final selected = i == _selectedColor;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedColor = i),
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: selected
                                    ? Border.all(
                                        color: theme.colorScheme.primary, width: 2)
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 24),

                      // Add to Favorites
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: theme.colorScheme.primary,
                          ),
                          label: Text(
                            isFav ? 'Remove from Favorites' : 'Add to Favorites',
                            style: TextStyle(color: theme.colorScheme.primary),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: theme.colorScheme.primary),
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            prodProv.toggleFavourite(p.id.toString());
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      // Add to Cart
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CartProvider>().add(p);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added to cart')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
