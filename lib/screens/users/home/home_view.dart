import 'package:flutter/material.dart';
import 'package:judah/screens/users/home/searchbar_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cart/cart_view.dart';
import 'item_deatils_view.dart';
import 'special_offers_view.dart';
import 'recommendation_view.dart';
import 'more_category_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String _currentAddress = "Times Square"; // Default
  String _selectedFilter = "All";

  // --- Dummy state for tracking item quantities in the list ---
  final Map<String, int> _itemQuantities = {};

  // Key to manage and close the bottom sheet
  PersistentBottomSheetController? _sheetController;


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

  // --- ENHANCED: Bottom Sheet Logic ---
  void _showCartConfirmationSheet(BuildContext context, String itemName, int quantity) {
    // If the sheet is already open, close it first to update the content,
    // or dismiss it if quantity is zero.
    if (_sheetController != null) {
      _sheetController!.close();
      _sheetController = null;
    }

    // Only show if quantity is greater than 0
    if (quantity > 0) {
      _sheetController = Scaffold.of(context).showBottomSheet(
            (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5)),
            ],
          ),
          // --- FIXED OVERFLOW ISSUE WITH EXPANDED ---
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Column wrapped in Expanded to prevent overflow
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$quantity x $itemName Added!",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "View your cart for checkout.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Button
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    _sheetController?.close(); // Close sheet
                    _sheetController = null;
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartView()));
                  },
                  child: const Text("View Cart"),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      // Builder is needed for the Scaffold.of(context) required by showBottomSheet
      body: Builder(
        builder: (context) {
          // Store the current context in a local variable to use it safely in callbacks
          final localContext = context;
          return CustomScrollView(
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
              SliverToBoxAdapter(child: _buildDiscountList(localContext)), // Use localContext
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // --- 5. RECOMMENDED FOR YOU ---
              SliverToBoxAdapter(
                  child: _buildSectionHeader("Recommended For You 😍", () {})),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: _buildFilterChips()),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              _buildRecommendedList(localContext), // Use localContext
              SliverToBoxAdapter(
                  child:
                  const SizedBox(height: 20)), // Added padding at the bottom
            ],
          );
        },
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

        _buildAppBarIcon(Icons.shopping_bag_outlined, () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CartView()),
          );
        }),
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
        readOnly: true,
        onTap: () {
          // Navigate to the new search screen
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SearchView()),
          );
        },
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
            onPressed: () {
              // --- NAVIGATION LOGIC ADDED HERE ---
              if (title == "Special Offers") {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SpecialOffersView()),
                );
              } else if (title == "Recommended For You 😍") {
                // Navigate to the new RecommendationView
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RecommendationView()),
                );
              } else {
                onSeeAll(); // Use the passed function for other sections
              }
            },
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

        // --- Added Logic for 'More' Navigation ---
        void onTapHandler() {
          if (category["name"] == "More") {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MoreCategoryView()),
            );
          } else {
            // Placeholder: Navigate to RecommendationView filtered by category
            // Example for future use:
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => RecommendationView(filter: category["name"])),
            // );
          }
        }

        // --- InkWell for tap detection ---
        return InkWell(
          onTap: onTapHandler, // Call the navigation logic
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container for the icon/emoji
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
              // Label
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
          ),
        );
      },
    );
  }

  // --- NEW: Quantity Control Button Helper ---
  Widget _buildQuantityButton(IconData icon, VoidCallback onTap, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  // --- 6. DISCOUNT LIST (Horizontal, UPDATED with Stepper) ---
  Widget _buildDiscountList(BuildContext context) {
    // Dummy Data for Discount Cards
    final items = [
      {"image": 'https://placehold.co/300x300/png?text=Food+Bowl', "title": "Salmon Poke Bowl", "subtitle": "Warung Bu Tini", "price": 12.50},
      {"image": 'https://placehold.co/300x300/png?text=Food+Bowl', "title": "Chicken Noodle Soup", "subtitle": "Warung Bu Tini", "price": 10.00},
      {"image": 'https://placehold.co/300x300/png?text=Food+Bowl', "title": "Vegetable Curry", "subtitle": "Warung Bu Tini", "price": 9.50},
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: (context, index) {
          return _buildDiscountCard(context, items[index]);
        },
      ),
    );
  }

  // --- 7. DISCOUNT CARD (UPDATED with Stepper) ---
  Widget _buildDiscountCard(BuildContext context, Map<String, dynamic> item) {
    String title = item["title"];
    int currentQuantity = _itemQuantities.containsKey(title) ? _itemQuantities[title]! : 0;

    // Logic for quantity changes
    void updateQuantity(int delta) {
      setState(() {
        int newQuantity = currentQuantity + delta;
        if (newQuantity <= 0) {
          _itemQuantities.remove(title);
        } else {
          _itemQuantities[title] = newQuantity;
        }
      });

      // Dynamic Bottom Sheet Logic
      _showCartConfirmationSheet(context, title, currentQuantity + delta);
    }

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
                  item["image"],
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
              // ADD BUTTON (TOP RIGHT)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: currentQuantity == 0
                      ? _buildQuantityButton(Icons.add, () => updateQuantity(1), AppColors.primary)
                      : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildQuantityButton(Icons.remove, () => updateQuantity(-1), AppColors.primary),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          currentQuantity.toString(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildQuantityButton(Icons.add, () => updateQuantity(1), AppColors.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Placeholder for text
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item["subtitle"],
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


  // --- 8. FILTER CHIPS (No change) ---
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

  // --- 9. RECOMMENDED LIST (Vertical) ---
  Widget _buildRecommendedList(BuildContext context) {
    // Dummy data for each card
    final items = [
      {
        "image": "https://placehold.co/300x300/png?text=Noodles",
        "title": "Vegetarian Noodles",
        "dist": "800 m",
        "rating": "4.9",
        "reviews": "(2.3k)",
        "price": 2.00
      },
      {
        "image": "https://placehold.co/300x300/png?text=Pizza",
        "title": "Pizza Hut - Lumintu",
        "dist": "1.2 km",
        "rating": "4.5",
        "reviews": "(1.9k)",
        "price": 1.50
      },
      {
        "image": "https://placehold.co/300x300/png?text=Burger",
        "title": "Mozarella Cheese Bu...",
        "dist": "1.6 km",
        "rating": "4.6",
        "reviews": "(1.5k)",
        "price": 2.50
      },
      {
        "image": "https://placehold.co/300x300/png?text=Salad",
        "title": "Healthy Salad Bowl",
        "dist": "2.1 km",
        "rating": "4.8",
        "reviews": "(1.1k)",
        "price": 3.00
      },
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          // This ensures that the context passed down to the card is the Builder's context
          // which is essential for the Scaffold.of(context) call inside _showCartConfirmationSheet
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildRestaurantCard(context, items[index]),
          );
        },
        childCount: items.length,
      ),
    );
  }

  // --- 10. RECOMMENDED CARD (UPDATED with Stepper) ---
  Widget _buildRestaurantCard(BuildContext context, Map<String, dynamic> item) {
    String title = item["title"] as String;
    // Ensure the item exists in the map, default to 0
    int currentQuantity = _itemQuantities.containsKey(title) ? _itemQuantities[title]! : 0;

    // --- Logic for quantity changes ---
    void updateQuantity(int delta) {
      setState(() {
        int newQuantity = currentQuantity + delta;
        if (newQuantity <= 0) {
          _itemQuantities.remove(title);
        } else {
          _itemQuantities[title] = newQuantity;
        }
      });

      // Dynamic Bottom Sheet Logic
      _showCartConfirmationSheet(context, title, currentQuantity + delta);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // Image (Tappable for Details View)
          InkWell(
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
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                      "\$${(item["price"] as double).toStringAsFixed(2)}",
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
          // Stepper/Like button
          if (currentQuantity == 0)
          // Show + icon to add the first item
            _buildQuantityButton(Icons.add, () => updateQuantity(1), AppColors.primary)
          else
          // Show Stepper (+ / quantity / -)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQuantityButton(Icons.remove, () => updateQuantity(-1), AppColors.primary),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    currentQuantity.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                _buildQuantityButton(Icons.add, () => updateQuantity(1), AppColors.primary),
              ],
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