import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// Screen for showing Rating & Reviews (Based on Screenshot 2.04.36 PM)
class ReviewView extends StatelessWidget {
  const ReviewView({super.key});

  final List<Map<String, dynamic>> _reviews = const [
    {
      "name": "Charolette Hanlin",
      "rating": 5,
      "text": "Excellent food. Menu is extensive and seasonal to a particularly high standard. Definitely fine dining",
      "likes": 938,
      "time": "6 days ago",
    },
    {
      "name": "Darron Kulikowski",
      "rating": 4,
      "text": "This is my absolute favorite restaurant in. The food is always fantastic and no matter what I order I am always delighted with my meal!",
      "likes": 863,
      "time": "2 weeks ago",
    },
    {
      "name": "Lauralee Quintero",
      "rating": 5,
      "text": "Delicious dishes, beautiful presentation, wide wine list and wonderful dessert. I recommend to everyone! I would like to order here again and again",
      "likes": 629,
      "time": "2 weeks ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Rating & Reviews"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Summary Section ---
            _buildRatingSummary(context),
            const SizedBox(height: 20),
            _buildFilterBar(context),
            const SizedBox(height: 30),
            // --- Reviews List ---
            ..._reviews.map((review) => _buildReviewCard(context, review)).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSummary(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Average Score
        Column(
          children: [
            Text(
              "4.8",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 40, color: AppColors.textDark),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star, color: Colors.orange, size: 20),
                Icon(Icons.star_half, color: Colors.orange, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "(4.8k reviews)",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded),
            ),
          ],
        ),
        const SizedBox(width: 30),
        // Rating Bars
        Expanded(
          child: Column(
            children: List.generate(5, (index) {
              int star = 5 - index;
              double percent = [0.85, 0.70, 0.50, 0.30, 0.20][index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Text("$star", style: const TextStyle(color: AppColors.textFaded)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildRatingBar(percent, context)),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(double percent, BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percent,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Row(
      children: [
        _buildReviewChip(context, "Sort by", Icons.sort),
        _buildReviewChip(context, "5", Icons.star),
        _buildReviewChip(context, "4", Icons.star),
        _buildReviewChip(context, "3", Icons.star),
      ],
    );
  }

  Widget _buildReviewChip(BuildContext context, String label, IconData icon) {
    bool isPrimary = label == "Sort by";
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Chip(
        avatar: Icon(icon, color: isPrimary ? AppColors.white : AppColors.primary, size: 18),
        label: Text(label),
        backgroundColor: isPrimary ? AppColors.primary : AppColors.white,
        side: BorderSide(color: isPrimary ? Colors.transparent : AppColors.primary, width: 1.5),
        labelStyle: TextStyle(
          color: isPrimary ? AppColors.white : AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, Map<String, dynamic> review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              const CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.cardBackground,
                child: Icon(Icons.person, color: AppColors.textFaded),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review["name"],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ...List.generate(review["rating"], (index) => const Icon(Icons.star, color: Colors.orange, size: 16)),
                        ...List.generate(review["rating"], (index) => const Icon(Icons.star_border, color: AppColors.textFaded, size: 16)),
                        const Spacer(),
                        const Icon(Icons.more_horiz, color: AppColors.textFaded),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review["text"],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.pink, size: 18),
              const SizedBox(width: 4),
              Text(
                review["likes"].toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 16),
              Text(
                review["time"],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded),
              ),
            ],
          ),
          const Divider(height: 30),
        ],
      ),
    );
  }
}