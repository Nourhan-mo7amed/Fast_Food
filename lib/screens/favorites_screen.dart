import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';
import 'product_detail_screen.dart';
import '../providers/theme_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Product> favoriteProducts;

  @override
  void initState() {
    super.initState();
    favoriteProducts = dummyProducts.take(3).toList();
    themeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  void _removeFromFavorites(Product product) {
    setState(() {
      favoriteProducts.remove(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} removed from favorites'),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: themeNotifier.isDark
            ? Colors.grey.shade900
            : Colors.white,
        appBar: AppBar(
          title: const Text(
            'My Favorites',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: themeNotifier.isDark
              ? Colors.grey.shade900
              : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: favoriteProducts.isEmpty
            ? _buildEmptyState()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          '${favoriteProducts.length} Favorite Items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themeNotifier.isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return _buildFavoriteItem(product);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          Text(
            'No Favorites Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Start adding your favorite items!',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: themeNotifier.isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: themeNotifier.isDark ? Colors.black26 : Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // صورة المنتج
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: product.id,
                  child: Image.asset(
                    product.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // معلومات المنتج
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeNotifier.isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: themeNotifier.isDark
                                ? Colors.grey.shade400
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),

              // أيقونة الحذف من المفضلة
              IconButton(
                onPressed: () => _removeFromFavorites(product),
                icon: const Icon(Icons.favorite, color: Colors.red, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
