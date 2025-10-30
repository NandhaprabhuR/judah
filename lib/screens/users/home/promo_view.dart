
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// Screen for viewing available promotions (Based on Screenshot 2.04.50 PM)
class PromoView extends StatelessWidget {
  const PromoView({super.key});

  final List<Map<String, dynamic>> _promos = const [
    {"title": "Promo New User", "subtitle": "Valid for new users", "claimed": false, "icon": Icons.person},
    {"title": "Free Delivery", "subtitle": "Free delivery max \$4", "claimed": true, "icon": Icons.delivery_dining},
    {"title": "Extra 20% OFF", "subtitle": "Discount 20% OFF", "claimed": false, "icon": Icons.percent},
    {"title": "Special Friday", "subtitle": "Only for friday", "claimed": false, "icon": Icons.event_note},
    {"title": "Promo New Menu", "subtitle": "Valid for new menu", "claimed": false, "icon": Icons.check},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Offers Are Available"),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _promos.length,
        itemBuilder: (context, index) {
          return _buildPromoCard(_promos[index]);
        },
      ),
    );
  }

  Widget _buildPromoCard(Map<String, dynamic> promo) {
    bool isClaimed = promo["claimed"];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon and Dots
          SizedBox(
            width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Green circle background
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(promo["icon"], color: AppColors.white, size: 20),
                ),
                // Decorative dots (simplified)
                Positioned.fill(
                  child: Center(
                    child: CustomPaint(
                      painter: _DotPainter(isClaimed: isClaimed),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo["title"],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark),
                ),
                Text(
                  promo["subtitle"],
                  style: TextStyle(color: AppColors.textFaded),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Claim Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: isClaimed ? null : () { /* Handle claim */ },
              style: ElevatedButton.styleFrom(
                backgroundColor: isClaimed ? AppColors.cardBackground : AppColors.primary,
                foregroundColor: isClaimed ? AppColors.textFaded : AppColors.white,
                minimumSize: Size(80, 40),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                isClaimed ? "Claimed" : "Claim",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter to draw the dots/pattern around the icon
class _DotPainter extends CustomPainter {
  final bool isClaimed;
  _DotPainter({required this.isClaimed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isClaimed ? AppColors.textFaded.withOpacity(0.5) : AppColors.primary.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    // Simplified dot pattern matching the screenshot aesthetic
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = 35.0; // Radius of the pattern spread

    for (int i = 0; i < 12; i++) {
      double angle = 2 * 3.14159 * i / 12;
      double x = centerX + radius * 0.45 * cos(angle);
      double y = centerY + radius * 0.45 * sin(angle);
      canvas.drawCircle(Offset(x, y), 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}