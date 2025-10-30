
import 'package:flutter/material.dart';
import 'package:judah/screens/users/wallet/topup_success_state_view.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:judah/screens/widgets/buttons_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinput/pinput.dart';


// Screen 76/77/78: Top Up E-Wallet (Multi-Step)
class TopUpView extends StatefulWidget {
  const TopUpView({super.key});

  @override
  State<TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String? _selectedMethod;
  double _selectedAmount = 50.00; // Default selection

  final List<double> _topUpAmounts = const [
    10, 20, 50, 100, 200, 250, 500, 750, 1000
  ];

  final List<Map<String, dynamic>> _methods = const [
    {"name": "PayPal", "value": "paypal", "icon": FontAwesomeIcons.paypal, "color": Color(0xFF00457C)},
    {"name": "Google Pay", "value": "google", "icon": FontAwesomeIcons.googlePay, "color": AppColors.textDark},
    {"name": "Apple Pay", "value": "apple", "icon": FontAwesomeIcons.apple, "color": AppColors.textDark},
    {"name": "**** **** **** 4679", "value": "card", "icon": FontAwesomeIcons.ccMastercard, "color": Colors.red},
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      // Final step action (PIN confirmation)
      _completeTopUp();
    }
  }

  void _completeTopUp() {
    // Navigate to the success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TopUpSuccessView(topUpAmount: _selectedAmount);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = _currentPage == 0
        ? "Top Up E-Wallet"
        : (_currentPage == 1 ? "Top Up E-Wallet" : "Enter Your PIN");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(title),
        centerTitle: false,
        actions: _currentPage == 0 ? [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          const SizedBox(width: 8)
        ] : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildAmountSelection(),
                _buildMethodSelection(),
                _buildPinEntry(),
              ],
            ),
          ),

          // --- Fixed Bottom Button ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PrimaryButton(
              text: _currentPage == 2 ? "Continue" : "Continue",
              onPressed: _currentPage == 1 && _selectedMethod == null
                  ? () {} // Disable if no method selected in step 2
                  : _nextPage,
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 1: Amount Selection ---
  Widget _buildAmountSelection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Enter the amount of top up", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "\$${_selectedAmount.toStringAsFixed(0)}",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 30),

          // Top Up Chips
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: _topUpAmounts.map((amount) {
              bool isSelected = _selectedAmount == amount;
              return ChoiceChip(
                label: Text("\$${amount.toStringAsFixed(0)}"),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedAmount = amount;
                  });
                },
                backgroundColor: isSelected ? AppColors.primary : AppColors.primaryLight,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              );
            }).toList(),
          ),

          // Number Pad Placeholder
          const SizedBox(height: 50),
          _buildNumberPad(),
        ],
      ),
    );
  }

  // --- STEP 2: Method Selection ---
  Widget _buildMethodSelection() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        ..._methods.map((method) => _buildMethodRow(method)).toList(),
        const SizedBox(height: 16),
        _buildAddNewCardButton(),
      ],
    );
  }

  // --- STEP 3: PIN Entry ---
  Widget _buildPinEntry() {
    // Pinput theme (reused from OTP view)
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: Theme.of(context).textTheme.headlineSmall,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.transparent),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary),
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Enter your PIN to confirm top up", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 40),

          // Pinput for PIN entry (4 digits)
          Pinput(
            length: 4,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            obscureText: true,
            showCursor: false,
            onCompleted: (pin) {
              // Automatically complete Top Up when PIN is entered
              _completeTopUp();
            },
          ),
          const SizedBox(height: 50),
          _buildNumberPad(obscure: true), // Use number pad for PIN input
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildMethodRow(Map<String, dynamic> method) {
    final bool isSelected = _selectedMethod == method["value"];

    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = method["value"];
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(method["icon"], color: method["color"], size: 30),
            const SizedBox(width: 16),
            Text(method["name"], style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.textFaded, width: 2),
                color: isSelected ? AppColors.primary : AppColors.white,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: AppColors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Handle Add New Card logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: const Text("Add New Card", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildNumberPad({bool obscure = false}) {
    // Simplified number pad placeholder
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 12, // 1-9, *, 0, delete
        itemBuilder: (context, index) {
          String text;
          IconData? icon;
          if (index < 9) {
            text = (index + 1).toString();
          } else if (index == 9) {
            text = "*";
          } else if (index == 10) {
            text = "0";
          } else {
            text = "";
            icon = Icons.backspace_outlined;
          }

          return Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: icon != null
                  ? Icon(icon, color: AppColors.textDark, size: 24)
                  : Text(
                text,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}