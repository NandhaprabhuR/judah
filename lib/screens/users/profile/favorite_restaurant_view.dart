import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Screen 81: My Favorite Restaurants
class FavoriteRestaurantsView extends StatelessWidget {
  const FavoriteRestaurantsView({super.key});

  final List<Map<String, dynamic>> _favorites = const [
    {"name": "The Breakfast Club", "dist": 1.4, "rating": 4.7, "reviews": 1.7, "price": 2.00, "promo": true, "image": "https://placehold.co/100x100/F0E68C/000?text=Food1"},
    {"name": "Custard's Last Stand", "dist": 1.6, "rating": 4.6, "reviews": 1.5, "price": 2.50, "promo": false, "image": "https://placehold.co/100x100/FF5722/000?text=Food2"},
    {"name": "Planet of the Salad", "dist": 0.8, "rating": 4.9, "reviews": 2.3, "price": 2.00, "promo": false, "image": "https://placehold.co/100x100/388E3C/000?text=Food3"},
    {"name": "Lord of the Wings", "dist": 1.2, "rating": 4.5, "reviews": 1.9, "price": 1.50, "promo": true, "image": "https://placehold.co/100x100/FFA000/000?text=Food4"},
    {"name": "Earth, Wind and Flour", "dist": 0.0, "rating": 0.0, "reviews": 0.0, "price": 0.00, "promo": false, "image": "https://placehold.co/100x100/B0E0E6/000?text=Food5"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text("My Favorite Restaurants"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          return _buildFavoriteCard(context, _favorites[index]);
        },
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          // Image with Promo Tag
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: NetworkImage(item["image"]), fit: BoxFit.cover),
                ),
              ),
              if (item["promo"])
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                    child: const Text("PROMO", style: TextStyle(color: AppColors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["name"], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("${item["dist"]} km", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textFaded)),
                    const Text(" | ", style: TextStyle(color: AppColors.textFaded)),
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(" ${item["rating"]}", style: Theme.of(context).textTheme.bodySmall),
                    Text(" (${item["reviews"]}k)", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textFaded)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.motorcycle, color: AppColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Text("\$${(item["price"] as double).toStringAsFixed(2)}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          // Favorite Icon
          const Icon(Icons.favorite, color: Colors.red, size: 24),
        ],
      ),
    );
  }
}