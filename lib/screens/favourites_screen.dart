// lib/screens/favourites_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/app_drawer.dart';
import '../widgets/filter_button.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prodProv   = context.watch<ProductProvider>();
    // First apply your existing filters/sorts, then pick out only the favs:
    final favIds      = prodProv.favs;
    final favProducts = prodProv.filteredProducts
        .where((p) => favIds.contains(p.id.toString()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        actions: [
          FilterButton(), // reuse the same filter UI
        ],
      ),
      drawer: AppDrawer(),
      body: favProducts.isEmpty
          ? Center(
              child: Text(
                'No favourites yet',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : RefreshIndicator(
              onRefresh: prodProv.fetchProducts,
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: favProducts.length,
                itemBuilder: (ctx, i) {
                  final p = favProducts[i];
                  return Stack(
                    children: [
                      ProductCard(
                        title: p.title,
                        price: p.price,
                        imageUrl: p.image,
                        rating: p.rating,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/product_detail',
                          arguments: p,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () =>
                              prodProv.toggleFavourite(p.id.toString()),
                          child: Icon(
                            prodProv.isFavourite(p.id.toString())
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
