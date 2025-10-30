import 'package:flutter/material.dart';
import 'package:judah/screens/users/home/recommendation_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// This screen displays all food categories in a grid (Screen 28)
class MoreCategoryView extends StatelessWidget {
  const MoreCategoryView({super.key});

  // Full list of categories from the screenshot
  final List<Map<String, String>> _categories = const [
    {"emoji": "🍔", "name": "Hambur.."},
    {"emoji": "🍕", "name": "Pizza"},
    {"emoji": "🍜", "name": "Noodles"},
    {"emoji": "🍖", "name": "Meat"},

    {"emoji": "🥬", "name": "Vegeta.."},
    {"emoji": "🍰", "name": "Dessert"},
    {"emoji": "🍺", "name": "Drink"},
    {"emoji": "🍞", "name": "Bread"},

    {"emoji": "🥐", "name": "Croissant"},
    {"emoji": "🥞", "name": "Pancakes"},
    {"emoji": "🧀", "name": "Cheese"},
    {"emoji": "🍟", "name": "French Fr.."},

    {"emoji": "🥪", "name": "Sandwich"},
    {"emoji": "🌮", "name": "Taco"},
    {"emoji": "🍲", "name": "Pot of Fo.."},
    {"emoji": "🥗", "name": "Salad"},

    {"emoji": "🍱", "name": "Bento"},
    {"emoji": "🍚", "name": "Cooked Ri.."},
    {"emoji": "🍝", "name": "Spaghet.."},
    {"emoji": "🍣", "name": "Sushi"},

    {"emoji": "🍨", "name": "Ice Crea.."},
    {"emoji": "🍪", "name": "Cookies"},
    {"emoji": "🧃", "name": "Beverag.."},
    {"emoji": "🥮", "name": "Others"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("More Category"),
        centerTitle: false,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20, // Vertical spacing
          crossAxisSpacing: 20, // Horizontal spacing
          childAspectRatio: 0.9, // Adjust height
        ),
        itemCount: _categories.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final category = _categories[index];
          return _buildCategoryItem(context, category);
        },
      ),
    );
  }

  /// Helper widget for a single category item that navigates
  Widget _buildCategoryItem(BuildContext context, Map<String, String> category) {
    // Determine the category name to pass as the filter
    // e.g., "Hambur.." -> "Hamburger", "Vegeta.." -> "Vegeta.."
    final filterName = category["name"]!.contains("..")
        ? category["name"]!.replaceAll("..", "")
        : category["name"]!;

    return InkWell(
      onTap: () {
        // Navigate to the RecommendationView and pass the selected category name
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const RecommendationView(), // TODO: Pass selected filter when RecommendationView is updated to accept it.
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              category["emoji"]!,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category["name"]!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}