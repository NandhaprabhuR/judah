import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';
import 'dart:math';

import 'item_deatils_view.dart';


// This is a placeholder for the Cart view (based on the provided screenshot)
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // --- DUMMY DATA ---
  // Note: Using a list of dynamic maps to allow removal
  final List<Map<String, dynamic>> _cartItems = [
    {
      "title": "Mixed Salad Bon...",
      "items": 3,
      "distance": 1.5,
      "price": 18.00,
      "imageColor": const Color(0xFFC7B1A5), // Color matching the first image background
    },
    {
      "title": "Dessert Cake - Lo...",
      "items": 4,
      "distance": 2.3,
      "price": 22.00,
      "imageColor": const Color(0xFF7A4F4F), // Color matching the second image background
    },
    {
      "title": "Japanese Kumpa...",
      "items": 3,
      "distance": 1.8,
      "price": 25.00,
      "imageColor": const Color(0xFF907080), // Color matching the third image background
    },
    {
      "title": "Vegetable Salad",
      "items": 5,
      "distance": 2.8,
      "price": 20.00,
      "imageColor": const Color(0xFF6B8E23), // Color matching the fourth image background
    },
    {
      "title": "Noodles & Beacon...",
      "items": 3,
      "distance": 1.5,
      "price": 19.00,
      "imageColor": const Color(0xFFB8860B), // Color matching the fifth image background
    },
  ];

  /// Function to remove an item from the cart list
  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    // Optionally show a snackbar for undo action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("My Cart"),
        centerTitle: true,
        actions: const [
          // The three-dot menu button
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_horiz),
          ),
        ],
      ),
      // Use Column and Expanded to prepare for a fixed bottom button (checkout)
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];

                // --- DISMISSIBLE WRAPPER (Swipe-to-Delete) ---
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Dismissible(
                    key: Key(item["title"].toString() + index.toString()), // Unique key for Dismissible
                    direction: DismissDirection.endToStart, // Only swipe left

                    // The background that appears when swiping
                    background: _buildDismissibleBackground(),

                    // Action when the item is dismissed
                    onDismissed: (direction) {
                      _removeItem(index);
                    },

                    // The actual cart item content (Wrapped in InkWell for navigation)
                    child: InkWell( // <-- WRAPPER ADDED FOR NAVIGATION
                      onTap: () {
                        // Navigate to Item Details when card is tapped (Required for Review/Promo screen access)
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ItemDetailsView(
                              itemName: item["title"],
                              itemImage: 'https://placehold.co/400x400/000/FFF?text=CartItem', // Placeholder image
                            ),
                          ),
                        );
                      },
                      child: _buildCartItemCard(item),
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Checkout Button Placeholder (Optional but good practice) ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PrimaryButton(
              onPressed: () {
                // TODO: Navigate to Checkout
              },
              text: "Checkout (5 items - \$104.00)",
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build the red background for swipe-to-delete
  Widget _buildDismissibleBackground() {
    // We match the cart item card's decoration for the background
    return Container(
      decoration: BoxDecoration(
        color: Colors.red, // Solid red color
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.3), // Slightly transparent white circle
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.delete_outline, // The trash icon
          color: AppColors.white,
          size: 30,
        ),
      ),
    );
  }

  /// Helper widget to build a single cart item card
  Widget _buildCartItemCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- Stacked Image Placeholder ---
          _buildStackedImages(item["imageColor"]),
          const SizedBox(width: 16),
          // --- Item Details ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Item count and distance
                Text(
                  "${item["items"]} items | ${item["distance"]} km",
                  style: const TextStyle(
                    color: AppColors.textFaded,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                // Price
                Text(
                  "\$${item["price"].toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to create the stacked image effect
  Widget _buildStackedImages(Color baseColor) {
    const double size = 70;
    const double offset = 8;

    return Stack(
      children: [
        // Back-most card (Darker border)
        Positioned(
          left: 2 * offset,
          child: _buildImageCircle(size, AppColors.border),
        ),
        // Middle card (Lighter background color)
        Positioned(
          left: 1 * offset,
          child: _buildImageCircle(size, AppColors.cardBackground),
        ),
        // Front-most image (The main food item)
        _buildImageCircle(size, baseColor, isFront: true),
      ],
    );
  }

  /// Helper to build a single circle in the stack
  Widget _buildImageCircle(double size, Color color, {bool isFront = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: isFront
            ? Border.all(color: AppColors.white, width: 2) // White border on front
            : null,
      ),
      // Placeholder image content for the front card
      child: isFront
          ? const Center(
        child: Icon(
          Icons.fastfood,
          color: AppColors.white,
          size: 35,
        ),
      )
          : null,
    );
  }
}