// lib/screens/order_state.dart

class OrderState {
  static Map<String, dynamic>? activeOrder;

  static void placeNewOrder(double total) {
    // Simulates saving a newly placed order after checkout
    activeOrder = {
      "name": "Big Garden Salad",
      "items": 3,
      "distance": 2.4,
      "price": total,
      "status": "Active",
      "image": "https://placehold.co/100x100/A3E4D7/000?text=Salad",
    };
  }

  static void completeActiveOrder() {
    // Moves the order to a completed state (for simulation purposes)
    activeOrder = null;
  }
}