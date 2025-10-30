import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';


import 'item_deatils_view.dart';
import 'order_state_view.dart';
import 'orders_placedview.dart';


class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- Base Dummy Data for Completed Orders (as requested) ---
  final List<Map<String, dynamic>> completedOrdersBase = const [
    {"name": "Zero Zero Noodles", "items": 4, "distance": 2.7, "price": 22.00, "status": "Completed", "image": "https://placehold.co/100x100/87CEEB/000?text=Noodles"},
    {"name": "Eats Meets West", "items": 2, "distance": 1.9, "price": 20.50, "status": "Completed", "image": "https://placehold.co/100x100/F0E68C/000?text=Rice"},
    {"name": "Gardenica Salad", "items": 3, "distance": 2.2, "price": 27.00, "status": "Completed", "image": "https://placehold.co/100x100/9ACD32/000?text=Salad"},
  ];
  final List<Map<String, dynamic>> cancelledOrders = const [];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- Order Again Navigation Logic (New) ---
  void _reorderItem(BuildContext context, Map<String, dynamic> item) {
    // Navigate back to the Item Details View to simulate adding the item to the cart again
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ItemDetailsView(
          itemName: item["name"],
          itemImage: item["image"],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // --- Dynamic Active Order List ---
    List<Map<String, dynamic>> activeOrders;
    bool hasActiveOrder = OrderState.activeOrder != null;

    if (hasActiveOrder) {
      // If a new order was placed, display only that one.
      activeOrders = [OrderState.activeOrder!];
    } else {
      // Otherwise, show the default dummy list for cancelled/old orders in the Active tab.
      activeOrders = [
        {"name": "Bite Me Sandwiches", "items": 3, "distance": 1.4, "price": 32.00, "status": "Cancelled", "image": "https://placehold.co/100x100/FFF8DC/000?text=Sandwich"},
        {"name": "Life of Salad", "items": 4, "distance": 2.5, "price": 24.00, "status": "Cancelled", "image": "https://placehold.co/100x100/ADFF2F/000?text=Salad"},
        {"name": "Toro Toro Nobati", "items": 2, "distance": 2.2, "price": 28.50, "status": "Cancelled", "image": "https://placehold.co/100x100/FFD700/000?text=Sushi"},
        {"name": "Jamaca La Salad", "items": 3, "distance": 1.7, "price": 22.00, "status": "Cancelled", "image": "https://placehold.co/100x100/98FB98/000?text=Salad"},
      ];
    }

    return Scaffold(
      appBar: AppBar(
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
        title: const Text("Orders", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textFaded),
            onPressed: () {
              // TODO: Implement search functionality for orders
            },
          ),
          const SizedBox(width: 16),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textFaded,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: "Active"),
            Tab(text: "Completed"),
            Tab(text: "Cancelled"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(activeOrders, type: "active", hasActiveOrder: hasActiveOrder), // Pass flag
          _buildOrderList(completedOrdersBase, type: "completed"),
          _buildOrderList(cancelledOrders, type: "cancelled"),
        ],
      ),
    );
  }

  // Helper to build the list of orders for each tab
  Widget _buildOrderList(List<Map<String, dynamic>> orders, {required String type, bool hasActiveOrder = false}) {
    if (orders.isEmpty && type != "active") { // Only show empty state for Completed/Cancelled
      return _buildEmptyOrdersState(type);
    }
    // For 'active' tab, if no specific active order, show the dummy list (which contains cancelled dummy orders)
    if (orders.isEmpty && type == "active" && !hasActiveOrder) {
      return _buildEmptyOrdersState(type); // Show the empty state placeholder
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderItemCard(context, order, type: type, isNewlyPlaced: hasActiveOrder); // Pass flag
      },
    );
  }

  // Helper to build a single order item card
  Widget _buildOrderItemCard(BuildContext context, Map<String, dynamic> order, {required String type, required bool isNewlyPlaced}) {
    // Determine the status text based on active/placed status
    String statusText = isNewlyPlaced ? "Placed" : order["status"];
    Color statusColor = isNewlyPlaced ? Colors.blue.shade600 : (type == "active" ? Colors.red : AppColors.primary);
    Color statusBgColor = isNewlyPlaced ? Colors.blue.shade100 : (type == "active" ? Colors.red.withOpacity(0.1) : AppColors.primaryLight);

    // If it is the active tab but no new order was placed, use red/cancelled styling (for the dummy data)
    if (type == "active" && !isNewlyPlaced) {
      statusColor = Colors.red;
      statusBgColor = Colors.red.withOpacity(0.1);
    }

    // If it is the active tab and the order is Newly Placed, use the blue "Placed" status
    if (isNewlyPlaced) {
      statusColor = Colors.blue.shade600;
      statusBgColor = Colors.blue.shade100;
    }


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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage(order["image"]), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              // Order Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order["name"],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${order["items"]} items | ${order["distance"]} km",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textFaded),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${order["price"].toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Status Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(statusText, style: TextStyle(color: statusColor, fontSize: 12)),
              ),
            ],
          ),
          // --- Action Buttons for Completed Orders ---
          if (type == "completed") ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement Leave a Review action
                      },
                      // Manual style for light green background and green text color
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text("Leave a Review", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  // Order Again button uses default PrimaryButton (solid green)
                  child: PrimaryButton(
                    onPressed: () => _reorderItem(context, order), // CALLS REORDER LOGIC
                    text: "Order Again",
                  ),
                ),
              ],
            ),
          ],
          // --- Action Buttons for Active Orders (Track Order) ---
          if (type == "active" && isNewlyPlaced) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      // Navigate to the success screen again (as a placeholder for a real tracking map)
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => OrderPlacedView(orderTotal: order["price"] as double)
                        ),
                      );
                    },
                    text: "Track Order",
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // Helper to build the empty state screen
  Widget _buildEmptyOrdersState(String type) {
    String message = "You do not have an active order at this time";
    if (type == "completed") {
      message = "You haven't completed any orders yet.";
    } else if (type == "cancelled") {
      message = "You don't have any cancelled orders.";
    }


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty state image
          Image.network(
            'https://placehold.co/150x150/E0E0E0/A9A9A9?text=Empty', // Generic placeholder
            height: 150,
            errorBuilder: (context, error, stackTrace) {
              return Stack( // Replicate clipboard icon for empty state
                alignment: Alignment.center,
                children: [
                  Icon(Icons.assignment, size: 100, color: AppColors.textFaded.withOpacity(0.3)),
                  Positioned(
                      top: 20, right: 20,
                      child: Icon(Icons.check_box_outline_blank, size: 50, color: AppColors.primary) // Top-right green clip
                  )
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Text("Empty", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textFaded),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}