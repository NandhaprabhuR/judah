import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'item_deatils_view.dart'; // NEW IMPORT

class RecommendationView extends StatefulWidget {
  const RecommendationView({super.key});

  @override
  State<RecommendationView> createState() => _RecommendationViewState();
}

class _RecommendationViewState extends State<RecommendationView> {
  String _selectedFilter = "All";

  // Full list of categories from the home screen grid, plus "All"
  final List<String> _categoryLabels = const [
    "All",
    "Hamburger",
    "Pizza",
    "Noodles",
    "Meat",
    "Vegeta..", // Vegetable
    "Dessert",
    "Drink",
    "Bread",
    "Croissant",
    "Pancakes",
    "Cheese",
    "French Fr..", // French Fries
    "Sandwich",
    "Taco",
    "Pot of Fo..", // Pot of Food
    "Salad",
    "Bento",
    "Cooked Ri..", // Cooked Rice
    "Spaghet..", // Spaghetti
    "Sushi",
    "Ice Crea..", // Ice Cream
    "Cookies",
    "Beverag..", // Beverage
    "Others"
  ];

  // Dummy data for the recommended restaurants (based on the screenshot)
  final List<Map<String, String>> _recommendedItems = const [
    {
      "image": "https://placehold.co/300x300/png?text=Noodles",
      "title": "Vegetarian Noodles",
      "dist": "800 m",
      "rating": "4.9",
      "reviews": "(2.3k)",
      "price": "2.00"
    },
    {
      "image": "https://placehold.co/300x300/png?text=Pizza",
      "title": "Pizza Hut - Lumintu",
      "dist": "1.2 km",
      "rating": "4.5",
      "reviews": "(1.9k)",
      "price": "1.50"
    },
    {
      "image": "https://placehold.co/300x300/png?text=Burger",
      "title": "Mozarella Cheese Bu...",
      "dist": "1.6 km",
      "rating": "4.6",
      "reviews": "(1.5k)",
      "price": "2.50"
    },
    {
      "image": "https://placehold.co/300x300/png?text=Fruit+Salad",
      "title": "Fruit Salad - Kumpa",
      "dist": "1.4 km",
      "rating": "4.7",
      "reviews": "(1.7k)",
      "price": "2.00"
    },
    {
      "image": "https://placehold.co/300x300/png?text=Pizza+Queen",
      "title": "Pizza Queen - Sanar..",
      "dist": "1.9 km",
      "rating": "4.3",
      "reviews": "(1.2k)",
      "price": "1.80"
    },
  ];

  // --- Helper to determine chip content based on label ---
  Map<String, dynamic> _getFilterData(String label) {
    // Note: Using placeholder icons for simplicity unless specific FA icons are required
    if (label == "All") {
      return {"icon": Icons.check, "iconColor": AppColors.white, "emoji": "✔"};
    } else if (label == "Hamburger") {
      return {"icon": Icons.lunch_dining, "iconColor": AppColors.primary, "emoji": "🍔"};
    } else if (label == "Pizza") {
      return {"icon": Icons.local_pizza_outlined, "iconColor": AppColors.primary, "emoji": "🍕"};
    } else if (label == "Drink") {
      return {"icon": Icons.local_bar, "iconColor": AppColors.primary, "emoji": "🍺"};
    }
    // Default for all other categories
    return {"icon": Icons.fastfood_outlined, "iconColor": AppColors.primary, "emoji": "⭐"};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom AppBar with back button and title
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "Recommended For You 😊",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            backgroundColor: AppColors.background,
            elevation: 0,
            toolbarHeight: 70,
          ),

          // --- STICKY FILTER CHIPS HEADER ---
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyFilterHeaderDelegate(
              height: 70.0,
              child: Container(
                color: AppColors.background,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: _buildFilterChips(),
              ),
            ),
          ),

          // --- RECOMMENDED LIST ---
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: _buildRestaurantCard(_recommendedItems[index]),
                );
              },
              childCount: _recommendedItems.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  // --- Filter Chips (Horizontal List) ---
  Widget _buildFilterChips() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categoryLabels.length,
        padding: const EdgeInsets.only(left: 24),
        itemBuilder: (context, index) {
          final label = _categoryLabels[index];
          final isSelected = _selectedFilter == label;
          final filterData = _getFilterData(label);

          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ActionChip(
              label: Text(label),
              onPressed: () {
                setState(() {
                  _selectedFilter = label;
                });
              },

              // Use Text for emoji/text icons to match the screenshot
              avatar: isSelected && label == "All"
                  ? Icon(filterData["icon"] as IconData, color: filterData["iconColor"] as Color, size: 18)
                  : Text(filterData["emoji"] as String, style: const TextStyle(fontSize: 18)),

              // --- Styling based on selection ---
              backgroundColor: isSelected ? AppColors.primary : AppColors.white,

              labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                // Label color is white when selected, primary green when unselected
                color: isSelected ? AppColors.white : AppColors.primary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  // Border is always primary green, slightly thicker when selected.
                  color: AppColors.primary,
                  width: isSelected ? 2.0 : 1.5,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        },
      ),
    );
  }

  // --- Restaurant Card (Matching HomeView Style) ---
  Widget _buildRestaurantCard(Map<String, String> item) {
    return InkWell( // <-- WRAPPER ADDED FOR NAVIGATION
        onTap: () {
          // Navigate to Item Details when card is tapped
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ItemDetailsView(
                itemName: item["title"]!,
                itemImage: item["image"]!,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.cardBackground, // Fallback color
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  item["image"]!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.fastfood, color: AppColors.textFaded, size: 40,),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"]!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          item["dist"]!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Text(" | ",
                            style: TextStyle(color: AppColors.textFaded)),
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(
                          " ${item["rating"]}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          " ${item["reviews"]}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textFaded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.motorcycle,
                            color: AppColors.primary, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          "\$${item["price"]}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Like button
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.favorite, color: Colors.pink.shade300, size: 24),
              ),
            ],
          ),
        )
    );
  }
}

// --- Delegate for Sticky Filter Header ---
class _StickyFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyFilterHeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyFilterHeaderDelegate oldDelegate) {
    return child != oldDelegate.child || height != oldDelegate.height;
  }
}