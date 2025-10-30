import 'package:flutter/material.dart';
// Make sure these imports match your project structure
// NEW: Ensure OrdersView is imported
import 'package:judah/screens/widgets/app_theme.dart';

import '../home/home_view.dart';
import '../orders/orders_view.dart';
import '../profile/profile_view.dart';
import '../wallet/e-wallet_view.dart';

class BottomNavbarView extends StatefulWidget {
  const BottomNavbarView({super.key});

  @override
  State<BottomNavbarView> createState() => _BottomNavbarViewState();
}

class _BottomNavbarViewState extends State<BottomNavbarView> {
  int _selectedIndex = 0;

  // Pages for each tab
  // 💡 FIX: We instantiate OrdersView here to force it to rebuild when selected.
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(), // Screen for "Home"
    const OrdersView(), // <<< CHANGE: Use the real OrdersView for dynamic rebuilds
    const EWalletView(),
    const ProfileView(),  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Use the list we created above.
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'E-Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textFaded,
        onTap: _onItemTapped,
        // These settings are important for 5 items
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: AppColors.white,
        elevation: 10,
      ),
    );
  }
}

// Helper widget for placeholder screens
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}