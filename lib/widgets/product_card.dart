// lib/widgets/product_card.dart

import 'dart:ui';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;
  final double rating;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Glass background: light theme gets darker tint, dark theme stays light
    final bgColor = isDark
        ? Colors.white.withOpacity(0.2)
        : Colors.black.withOpacity(0.1);
    final borderColor = isDark
        ? Colors.white.withOpacity(0.3)
        : Colors.black.withOpacity(0.2);

    // Text colors for contrast
    final titleColor = isDark ? Colors.white : Colors.black87;
    final priceColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
            ),
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image
                  Expanded(
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),

                  // Title, Price & Rating
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: titleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),

                        // Price
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: priceColor,
                          ),
                        ),
                        SizedBox(height: 6),

                        // Rating Stars
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              i < rating.round() ? Icons.star : Icons.star_border,
                              size: 16,
                              color: Colors.amber,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
