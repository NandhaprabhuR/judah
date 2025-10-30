import 'package:flutter/material.dart';
import 'package:judah/screens/payment_method_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';

// This is Screen 45: Checkout Orders
class CheckoutOrdersView extends StatelessWidget {
  const CheckoutOrdersView({super.key});

  // Dummy data for order summary
  final List<Map<String, dynamic>> _orderItems = const [
    {"name": "Mixed Vegetable Salad", "price": 12.00, "qty": 1, "image": "https://placehold.co/100x100/A3E4D7/000?text=Veg"},
    {"name": "Special Pasta Salad", "price": 8.00, "qty": 1, "image": "https://placehold.co/100x100/ADD8E6/000?text=Pasta"},
    {"name": "Fresh Avocado Juice", "price": 4.00, "qty": 1, "image": "https://placehold.co/100x100/BFFF00/000?text=Avocado"},
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate totals
    final double subtotal = _orderItems.fold(0, (sum, item) => sum + (item["price"] * item["qty"]));
    const double deliveryFee = 2.00;
    final double total = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Checkout Orders"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Deliver To ---
            Text("Deliver to", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDeliveryLocation(context),

            const SizedBox(height: 30),
            const Divider(color: AppColors.border),

            // --- 2. Order Summary ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Summary", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text("Add Items", style: TextStyle(color: AppColors.primary))),
              ],
            ),
            const SizedBox(height: 16),
            ..._orderItems.map((item) => _buildOrderItemRow(context, item)).toList(),

            const SizedBox(height: 20),

            // --- 3. Payment and Discounts ---
            _buildActionRow(context, "Payment Methods", Icons.credit_card, () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaymentMethodsView()));
            }),
            _buildActionRow(context, "Get Discounts", Icons.local_offer, () {
              // TODO: Navigate to Promo View
            }),

            const SizedBox(height: 30),

            // --- 4. Totals ---
            _buildTotalRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}", isTotal: false),
            _buildTotalRow("Delivery Fee", "\$${deliveryFee.toStringAsFixed(2)}", isTotal: false),
            _buildTotalRow("Total", "\$${total.toStringAsFixed(2)}", isTotal: true),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PrimaryButton(
          text: "Place Order - \$${total.toStringAsFixed(2)}",
          onPressed: () {
            // Final action button
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaymentMethodsView()));
          },
        ),
      ),
    );
  }

  Widget _buildDeliveryLocation(BuildContext context) {
    return InkWell(
      onTap: () { /* TODO: Edit location */ },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Home", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                        child: const Text("Default", style: TextStyle(color: AppColors.primary, fontSize: 12)),
                      ),
                    ],
                  ),
                  Text("Times Square NYC, Manhattan", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textFaded)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textFaded, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemRow(BuildContext context, Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage(item["image"]), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          // Name and Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["name"], style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                Text("\$${item["price"].toStringAsFixed(2)}", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Quantity and Edit
          Text("${item["qty"]}x", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Icon(Icons.edit, color: AppColors.textFaded, size: 18),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 12),
            Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textFaded, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, String amount, {required bool isTotal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.textDark : AppColors.textLight,
            fontSize: isTotal ? 16 : 14,
          )),
          Text(amount, style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.primary : AppColors.textDark,
            fontSize: isTotal ? 16 : 14,
          )),
        ],
      ),
    );
  }
}