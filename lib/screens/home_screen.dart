import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/category_item.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import 'profile_screen.dart';
import 'favorites_screen.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ["Burgers", "Pizza", "Sandwiches", "Drinks"];
  int selectedIndex = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Listen to theme changes
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(Icons.location_on, size: 28, color: Colors.orange),
              const Text(
                "Mansoura",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_drop_down_sharp, size: 28, color: Colors.orange),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                themeNotifier.toggleTheme();
              },
              icon: Icon(
                themeNotifier.isDark ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Order Your Food \n Fast and Free",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(
                  "assets/images/delivery.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for food...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: themeNotifier.isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: categories.length,
                itemBuilder: (ctx, i) => CategoryItem(
                  title: categories[i],
                  isSelected: selectedIndex == i,
                  onTap: () => setState(() => selectedIndex = i),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: dummyProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, i) => ProductCard(
                  product: dummyProducts[i],
                  onTap: () {
                    Navigator.of(ctx).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailScreen(product: dummyProducts[i]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            // Navigate to Favorites screen when Favorites tab is tapped
            if (index == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            }

            // Navigate to Profile screen when Profile tab is tapped
            if (index == 2) {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
