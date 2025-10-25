import 'package:flutter/material.dart';
// Make sure these imports match your project structure
// import 'package:judah/screens/home_controller.dart'; // <-- REMOVED
import 'package:judah/screens/widgets/app_theme.dart';
// Using a built-in icon for the delivery bike
// If you want the exact icon, you might need another package
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final HomeController _controller = HomeController(); // <-- REMOVED
  final String _currentAddress = "Times Square"; // Default
  String _selectedFilter = "All";

  // Dummy data for the UI
  final List<Map<String, String>> categories = [
    {"emoji": "🍔", "name": "Hambur.."},
    {"emoji": "🍕", "name": "Pizza"},
    {"emoji": "🍜", "name": "Noodles"},
    {"emoji": "🍖", "name": "Meat"},
    {"emoji": "🥬", "name": "Vegeta.."},
    {"emoji": "🍰", "name": "Dessert"},
    {"emoji": "🍺", "name": "Drink"},
    {"emoji": "🥮", "name": "More"},
  ];

  final List<String> filters = ["All", "Hamburger", "Pizza", "Drink", "Meat"];

  // REMOVED initState() and _fetchLocation() as they are no longer needed
  /*
  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  void _fetchLocation() async {
    // We're not using the full address, just the first part
    String address = await _controller.getUserLocationAddress();
    if (address.contains(",")) {
      address = address.split(',')[0];
    }
    if (mounted) {
      setState(() {
        _currentAddress = address;
      });
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      // --- REFACTORED TO CustomScrollView ---
      body: CustomScrollView(
        slivers: [
          // --- 1. SEARCH BAR ---
          SliverToBoxAdapter(child: _buildSearchBar()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // --- 2. SPECIAL OFFERS ---
          SliverToBoxAdapter(child: _buildSectionHeader("Special Offers", () {})),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildSpecialOfferBanner()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // --- 3. STICKY CATEGORY GRID ---
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyCategoryHeaderDelegate(
              // We calculate the height of the grid:
              // (2 rows * ~84 height) + (16 spacing) + (16 top padding) + (16 bottom padding)
              height: 216.0,
              child: Container(
                color: AppColors.background,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: _buildCategoryGrid(),
              ),
            ),
          ),

          // --- 4. DISCOUNT GUARANTEED ---
          SliverToBoxAdapter(child: const SizedBox(height: 24)),
          SliverToBoxAdapter(
              child: _buildSectionHeader("Discount Guaranteed! 🔥", () {})),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildDiscountList()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // --- 5. RECOMMENDED FOR YOU ---
          SliverToBoxAdapter(
              child: _buildSectionHeader("Recommended For You 😍", () {})),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildFilterChips()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _buildRecommendedList(), // This now returns a SliverList
          SliverToBoxAdapter(
              child:
              const SizedBox(height: 20)), // Added padding at the bottom
        ],
      ),
    );
  }

  // --- 1. APP BAR ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.background,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        // --- IMAGE FIX ---
        // Switched to CircleAvatar for better error handling
        child: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.cardBackground,
          backgroundImage:
          const NetworkImage('https://placehold.co/100x100'),
          onBackgroundImageError: (e, s) =>
              debugPrint('AppBar Image Error: $e'),
          child: const Icon(Icons.person, color: AppColors.textFaded),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver to",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textFaded),
          ),
          Row(
            children: [
              Text(
                _currentAddress, // Now uses the default value
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.primary),
              ),
              const Icon(Icons.arrow_drop_down, color: AppColors.primary),
            ],
          ),
        ],
      ),
      actions: [
        _buildAppBarIcon(Icons.notifications_outlined, () {}),
        _buildAppBarIcon(Icons.shopping_bag_outlined, () {}),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onPressed) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(icon,
              color: AppColors.textFaded,
              size: 28), // <-- FIXED: textMain to textFaded
          onPressed: onPressed,
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // --- 2. SEARCH BAR ---
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "What are you craving?",
          prefixIcon: const Icon(Icons.search, color: AppColors.textFaded),
          filled: true,
          fillColor: AppColors.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // --- 3. SECTION HEADER ---
  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // --- 4. SPECIAL OFFER BANNER ---
  Widget _buildSpecialOfferBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            // Text
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "30%",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "DISCOUNT ONLY",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                    Text(
                      "VALID FOR TODAY!",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
            // Image
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomRight,
                // --- IMAGE FIX ---
                child: Image.network(
                  'https://placehold.co/300x200/png?text=Burger', // Placeholder
                  height: 130,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 130,
                      child: Center(
                          child: Text("Burger",
                              style: TextStyle(color: AppColors.white))),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 5. CATEGORY GRID ---
  Widget _buildCategoryGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        // --- OVERFLOW FIX ---
        childAspectRatio: 0.9, // Make cell slightly taller
      ),
      itemCount: categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        final category = categories[index];
        // --- OVERFLOW FIX ---
        // This Column was overflowing.
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child:
              Text(category["emoji"]!, style: const TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 4), // Reduced spacing
            Text(
              category["name"]!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 11), // Made text smaller
              maxLines: 1, // Prevent wrapping
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  // --- 6. DISCOUNT LIST (Horizontal) ---
  Widget _buildDiscountList() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Dummy count
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: (context, index) {
          return _buildDiscountCard();
        },
      ),
    );
  }

  Widget _buildDiscountCard() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with PROMO tag
          Stack(
            children: [
              // --- IMAGE FIX ---
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.cardBackground, // Fallback color
                ),
                clipBehavior: Clip.antiAlias, // Clips the image
                child: Image.network(
                  'https://placehold.co/300x300/png?text=Food+Bowl',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text("Food Bowl",
                          style: TextStyle(color: AppColors.textFaded)),
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "PROMO",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Placeholder for text
          Text(
            "Salmon Poke Bowl",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Warung Bu Tini",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textFaded),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- 7. FILTER CHIPS ---
  Widget _buildFilterChips() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              backgroundColor:
              isSelected ? AppColors.primary : AppColors.cardBackground,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.white : AppColors.textFaded,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              avatar: isSelected
                  ? const Icon(Icons.check, color: AppColors.white, size: 16)
                  : null, // No avatar for unselected
              shape: StadiumBorder(
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }

  // --- 8. RECOMMENDED LIST (Vertical) ---
  // --- REFACTORED to return a SliverList ---
  Widget _buildRecommendedList() {
    // Dummy data for each card
    final items = [
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
        "image": "https://placehold.co/300x300/png?text=Salad",
        "title": "Healthy Salad Bowl",
        "dist": "2.1 km",
        "rating": "4.8",
        "reviews": "(1.1k)",
        "price": "3.00"
      },
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildRestaurantCard(items[index]),
          );
        },
        childCount: items.length,
      ),
    );
  }

  Widget _buildRestaurantCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // Image
          // --- IMAGE FIX ---
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.cardBackground, // Fallback color
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              item["image"]!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.fastfood, color: AppColors.textFaded),
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
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      item["dist"]!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Text(" | ",
                        style: TextStyle(color: AppColors.textFaded)),
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(
                      " ${item["rating"]}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      " ${item["reviews"]}",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.textFaded),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.motorcycle,
                        color: AppColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      "\$${item["price"]}",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Like button
          IconButton(
            icon: const Icon(Icons.favorite_border,
                color: AppColors.border, size: 28),
            onPressed: () {
              // TODO: Handle like
            },
          ),
        ],
      ),
    );
  }
}

// --- NEW CLASS FOR THE STICKY HEADER ---
class _StickyCategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyCategoryHeaderDelegate({
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
    return child;
  }

  @override
  bool shouldRebuild(_StickyCategoryHeaderDelegate oldDelegate) {
    return child != oldDelegate.child || height != oldDelegate.height;
  }
}

