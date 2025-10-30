import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'promo_view.dart';
import 'review_view.dart';

// Screen for individual dish details (Based on Screenshot 2.03.54 PM)
class ItemDetailsView extends StatefulWidget {
  final String itemName;
  final String itemImage; // For display purposes

  const ItemDetailsView({
    super.key,
    required this.itemName,
    required this.itemImage,
  });

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  int _itemQuantity = 1;

  void _incrementQuantity() {
    setState(() {
      _itemQuantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_itemQuantity > 1) {
        _itemQuantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Top Image with AppBar Overlays ---
            _buildHeaderImage(context),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 2. Title and Quantity Controls ---
                  _buildTitleAndQuantity(context),
                  const SizedBox(height: 16),

                  // --- 3. Rating, Distance, Offers ---
                  _buildDetailRow(context, "4.8", "(4.8k reviews)", Icons.star, Colors.orange, () {
                    // Navigate to Review Screen
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ReviewView()));
                  }),
                  _buildDetailRow(context, "2.4 km", "Delivery Now | \$2.00", Icons.location_on, AppColors.primary, () {
                    // TODO: Navigate to location/delivery info
                  }),
                  _buildDetailRow(context, "Offers are available", "", Icons.local_offer, AppColors.primary, () {
                    // Navigate to Promo Screen
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PromoView()));
                  }),

                  const SizedBox(height: 30),
                  Text("For You", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // --- 4. Menu Items (Horizontal) ---
                  _buildHorizontalMenu(),

                  const SizedBox(height: 30),
                  Text("Menu", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // --- 5. Full Menu (Vertical) ---
                  _buildVerticalMenu(),
                ],
              ),
            ),
          ],
        ),
      ),
      // --- Floating Bottom Button (Add to Cart) ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PrimaryButton(
          text: "Add to Cart | \$_totalPrice", // Placeholder total
          onPressed: () {
            // TODO: Add item to global cart state
            Navigator.of(context).pop(); // Go back after adding
          },
        ),
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.itemImage),
              fit: BoxFit.cover,
            ),
          ),
          // Fallback/dark overlay
          child: Container(color: Colors.black.withOpacity(0.2)),
        ),
        // Custom AppBar
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                _buildCircularButton(Icons.arrow_back, () => Navigator.of(context).pop()),
                // Right Icons
                Row(
                  children: [
                    _buildCircularButton(Icons.favorite_border, () {}),
                    const SizedBox(width: 8),
                    _buildCircularButton(Icons.share, () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.textDark),
        onPressed: onTap,
      ),
    );
  }


  Widget _buildTitleAndQuantity(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.itemName,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        // Quantity +/- buttons
        Row(
          children: [
            _buildQuantityButton(Icons.remove, _decrementQuantity, AppColors.textFaded),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                _itemQuantity.toString(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
            _buildQuantityButton(Icons.add, _incrementQuantity, AppColors.primary),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String mainText, String subText, IconData icon, Color iconColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Text(
              mainText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.w600),
            ),
            if (subText.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                subText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded),
              ),
            ],
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textFaded, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalMenu() {
    // Matches the "For You" section in the screenshot
    final List<Map<String, dynamic>> forYouItems = const [
      {"name": "Mixed Vegetable Salad", "price": 12.00, "isBestSeller": true, "image": "https://placehold.co/100x100/A3E4D7/000?text=Veg"},
      {"name": "Fruit & Spice Salad", "price": 10.00, "isBestSeller": false, "image": "https://placehold.co/100x100/F0E68C/000?text=Fruit"},
      {"name": "Mixed Caesar Salad", "price": 9.50, "isBestSeller": false, "image": "https://placehold.co/100x100/D3D3D3/000?text=Caesar"},
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forYouItems.length,
        itemBuilder: (context, index) {
          final item = forYouItems[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _buildMenuItemCard(context, item, isBestSeller: item["isBestSeller"]),
          );
        },
      ),
    );
  }

  Widget _buildVerticalMenu() {
    // Matches the "Menu" and "Drink" sections in the screenshot
    final List<Map<String, dynamic>> menuItems = const [
      {"name": "Special Bound Salad", "price": 10.50, "tag": "NEW", "isDrink": false, "image": "https://placehold.co/100x100/90EE90/000?text=Bound"},
      {"name": "Special Pasta Salad", "price": 8.00, "tag": null, "isDrink": false, "image": "https://placehold.co/100x100/ADD8E6/000?text=Pasta"},
      {"name": "Mixed Caesar Salad", "price": 9.50, "tag": null, "isDrink": false, "image": "https://placehold.co/100x100/D3D3D3/000?text=Caesar"},
      {"name": "Fresh Avocado Juice", "price": 4.00, "tag": "PROMO", "isDrink": true, "image": "https://placehold.co/100x100/BFFF00/000?text=Avocado"},
      {"name": "Fresh Orange Juice", "price": 3.00, "tag": null, "isDrink": true, "image": "https://placehold.co/100x100/FFA500/000?text=Orange"},
      {"name": "Fresh Mango Juice", "price": 5.00, "tag": null, "isDrink": true, "image": "https://placehold.co/100x100/FFD700/000?text=Mango"},
    ];

    // Group the items visually by type (Menu / Drink)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...menuItems.where((i) => !i["isDrink"]).map((item) => _buildMenuItemRow(context, item)).toList(),
        const SizedBox(height: 30),
        Text("Drink", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...menuItems.where((i) => i["isDrink"]).map((item) => _buildMenuItemRow(context, item)).toList(),
      ],
    );
  }

  // Horizontal Menu Item Card (For "For You" section)
  Widget _buildMenuItemCard(BuildContext context, Map<String, dynamic> item, {required bool isBestSeller}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Image
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: NetworkImage(item["image"]), fit: BoxFit.cover),
                ),
              ),
              if (isBestSeller) // Best Seller tag
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                    child: const Text("Best Seller", style: TextStyle(color: AppColors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(item["name"], style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text("\$${item["price"].toStringAsFixed(2)}", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Vertical Menu Item Row (For "Menu" and "Drink" sections)
  Widget _buildMenuItemRow(BuildContext context, Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: NetworkImage(item["image"]), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(item["name"], style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    // + / - Quantity Control (Hidden in this view)
                  ],
                ),
                Text("\$${item["price"].toStringAsFixed(2)}", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Tag (NEW/PROMO)
          if (item["tag"] != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: item["tag"] == "NEW" ? Colors.blue.shade100 : AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item["tag"],
                style: TextStyle(
                  color: item["tag"] == "NEW" ? Colors.blue : AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}