import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';

// Screen 75: Transaction History
class TransactionHistoryView extends StatelessWidget {
  const TransactionHistoryView({super.key});

  // Re-using the dummy data structure from EWalletView
  final List<Map<String, dynamic>> _transactions = const [
    {"name": "Big Garden Salad", "date": "Dec 15, 2024 | 16:00 PM", "amount": 21.20, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/388E3C/FFF?text=Salad"},
    {"name": "Top Up E-Wallet", "date": "Dec 14, 2024 | 16:42 PM", "amount": 40.00, "type": "Top up", "isCredit": true, "image": "https://placehold.co/100x100/00B14F/FFF?text=E"},
    {"name": "Vegetable Salad", "date": "Dec 14, 2024 | 11:39 AM", "amount": 24.00, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/9CCC65/FFF?text=Veg"},
    {"name": "Mixed Salad Bonbon", "date": "Dec 13, 2024 | 14:46 PM", "amount": 28.50, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/FFA726/FFF?text=Mix"},
    {"name": "Top Up E-Wallet", "date": "Dec 12, 2024 | 09:27 AM", "amount": 50.00, "type": "Top up", "isCredit": true, "image": "https://placehold.co/100x100/00B14F/FFF?text=E"},
    {"name": "Toro Toro Nabati", "date": "Dec 13, 2024 | 14:46 PM", "amount": 28.50, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/FFD700/000?text=Sushi"},
    {"name": "Jamaica La Salad", "date": "Dec 13, 2024 | 14:46 PM", "amount": 28.50, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/98FB98/000?text=Salad"},
    {"name": "World of Greeny", "date": "Dec 13, 2024 | 14:46 PM", "amount": 28.50, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/9ACD32/000?text=Food"},
    {"name": "Top Up E-Wallet", "date": "Dec 12, 2024 | 09:27 AM", "amount": 50.00, "type": "Top up", "isCredit": true, "image": "https://placehold.co/100x100/00B14F/FFF?text=E"},
    {"name": "Gardenica Foodies", "date": "Dec 13, 2024 | 14:46 PM", "amount": 28.50, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/87CEEB/000?text=Food"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Transaction History"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final tx = _transactions[index];
          return _buildTransactionRow(context, tx);
        },
      ),
    );
  }

  // Re-using the row building logic from EWalletView
  Widget _buildTransactionRow(BuildContext context, Map<String, dynamic> tx) {
    bool isCredit = tx["isCredit"] as bool;

    Widget leadingWidget;
    if (tx["type"] == "Orders") {
      leadingWidget = Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(tx["image"]), fit: BoxFit.cover),
        ),
      );
    } else {
      leadingWidget = Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryLight,
        ),
        child: const Icon(Icons.account_balance_wallet, color: AppColors.primary, size: 24),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          leadingWidget,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx["name"], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text(tx["date"], style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textFaded)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isCredit ? '+' : '-'}\$${(tx["amount"] as double).toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isCredit ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                children: [
                  Text(tx["type"], style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textFaded)),
                  Icon(
                      isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isCredit ? Colors.green : Colors.red,
                      size: 14
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}