import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// This screen displays all special offers (Screen 20)
class SpecialOffersView extends StatelessWidget {
  const SpecialOffersView({super.key});

  final List<Map<String, dynamic>> _offers = const [
    {
      "percent": "30%",
      "color": AppColors.primary,
      "imagePath": 'https://placehold.co/300x200/png?text=Burger',
    },
    {
      "percent": "15%",
      "color": Color(0xFFFF9800), // Orange
      "imagePath": 'https://placehold.co/300x200/png?text=Salad',
    },
    {
      "percent": "20%",
      "color": Color(0xFFE91E63), // Pink/Red
      "imagePath": 'https://placehold.co/300x200/png?text=Green+Salad',
    },
    {
      "percent": "25%",
      "color": Color(0xFF2196F3), // Blue
      "imagePath": 'https://placehold.co/300x200/png?text=Noodles',
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
        title: const Text("Special Offers"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _offers.length,
        itemBuilder: (context, index) {
          return _buildOfferCard(context, _offers[index]);
        },
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, Map<String, dynamic> offer) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: offer["color"] as Color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Text Section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer["percent"] as String,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.bold),
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
          // Image Section
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  offer["imagePath"] as String,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: AppColors.white.withOpacity(0.5),
                      child: Center(
                          child: Text(
                            "Image",
                            style: TextStyle(color: offer["color"]),
                          )),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}