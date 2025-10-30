import 'package:flutter/material.dart';
import 'package:judah/screens/users/wallet/topup_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';


import '../transactions/transaction_history_view.dart';

// Screen 74: E-Wallet View
class EWalletView extends StatelessWidget {
  const EWalletView({super.key});

  // Dummy Transaction Data (Simulation: Order placed results in a DEBIT, Top Up is CREDIT)
  final List<Map<String, dynamic>> _transactions = const [
    {"name": "Big Garden Salad", "date": "Dec 15, 2024 | 16:00 PM", "amount": 21.20, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/388E3C/FFF?text=Salad"},
    {"name": "Top Up E-Wallet", "date": "Dec 14, 2024 | 16:42 PM", "amount": 40.00, "type": "Top up", "isCredit": true, "image": "https://placehold.co/100x100/00B14F/FFF?text=E"},
    {"name": "Vegetable Salad", "date": "Dec 14, 2024 | 11:39 AM", "amount": 24.00, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/9CCC65/FFF?text=Veg"},
    {"name": "Mixed Salad Bonbon", "date": "Dec 13, 2024 | 14:46 PM", "amount": 28.50, "type": "Orders", "isCredit": false, "image": "https://placehold.co/100x100/FFA726/FFF?text=Mix"},
    {"name": "Top Up E-Wallet", "date": "Dec 12, 2024 | 09:27 AM", "amount": 50.00, "type": "Top up", "isCredit": true, "image": "https://placehold.co/100x100/00B14F/FFF?text=E"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Wallet"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWalletCard(context),
              const SizedBox(height: 30),

              // --- Transaction History Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Transaction History", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TransactionHistoryView()));
                    },
                    child: const Text("See All", style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- Transaction List Preview ---
              ..._transactions.take(5).map((tx) => _buildTransactionRow(context, tx)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Andrew Ainsley", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                  const Text("•••• •••• •••• 3629", style: TextStyle(color: AppColors.white, fontSize: 16)),
                ],
              ),
              const Icon(Icons.credit_card, color: AppColors.white, size: 40),
            ],
          ),
          const SizedBox(height: 24),
          const Text("Your balance", style: TextStyle(color: AppColors.white, fontSize: 14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$9,379", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.white)),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TopUpView()));
                  },
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text("Top Up", style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(BuildContext context, Map<String, dynamic> tx) {
    bool isCredit = tx["isCredit"] as bool;

    // Determine icon/image and background color for the row
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