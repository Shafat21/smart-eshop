// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/filter_button.dart';
import '../widgets/product_card.dart';
import '../widgets/category_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollCtl     = ScrollController();
  final GlobalKey      _allProductsKey = GlobalKey();

  @override
  void dispose() {
    _scrollCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prodProv       = context.watch<ProductProvider>();
    final cartProv       = context.watch<CartProvider>();
    final productsToShow = prodProv.filteredProducts;
    final theme          = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.store, size: 20),
            SizedBox(width: 4),
            Text('Smart Eshop'),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: prodProv.loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: prodProv.fetchProducts,
              child: SingleChildScrollView(
                controller: _scrollCtl,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),

                    // Explore title...
                    Text(
                      'Explore',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'best Outfits for you',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.hintColor),
                    ),
                    SizedBox(height: 16),

                    // ─── Search + Filter ────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (text) => context
                                .read<ProductProvider>()
                                .setSearchQuery(text),
                            decoration: InputDecoration(
                              hintText: 'Search items…',
                              prefixIcon: Icon(Icons.search),
                              filled: true,
                              fillColor: theme.cardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        FilterButton(),
                      ],
                    ),
                    SizedBox(height: 24),

                    // ─── Category carousel ─────────────────────────────
                    CategoryCarousel(),
                    SizedBox(height: 24),

                    // ─── New Arrival header + See All ──────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Arrival',
                          style: theme.textTheme.titleLarge,
                        ),
                        TextButton(
                          onPressed: () {
                            if (_allProductsKey.currentContext != null) {
                              Scrollable.ensureVisible(
                                _allProductsKey.currentContext!,
                                duration: Duration(milliseconds: 350),
                              );
                            }
                          },
                          child: Text('See All'),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // ─── Horizontal carousel ───────────────────────────
                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: productsToShow.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: 16),
                        itemBuilder: (ctx, i) {
                          final p = productsToShow[i];
                          return SizedBox(
                            width: 160,
                            child: ProductCard(
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
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),

                    // ─── All Products header (tagged) ────────────────
                    Container(
                      key: _allProductsKey,
                      child: Text(
                        'All Products',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 12),

                    // ─── Full products grid ────────────────────────────
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productsToShow.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (ctx, i) {
                        final p = productsToShow[i];
                        return ProductCard(
                          title: p.title,
                          price: p.price,
                          imageUrl: p.image,
                          rating: p.rating,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/product_detail',
                            arguments: p,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: AppBottomNavBar(),
    );
  }
}
