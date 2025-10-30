import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Screen 90-92: Help Center (FAQ and Contact Us)
class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _faqCategories = ["General", "Account", "Service", "Payment"];

  final List<Map<String, String>> _faqItems = const [
    {"question": "What is Foodu?", "answer": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."},
    {"question": "How can I make a payment?", "answer": "Detailed steps on how to complete a payment through various methods."},
    {"question": "How do I cancel orders?", "answer": "Information regarding the cancellation process and eligibility."},
    {"question": "How do I delete my account?", "answer": "Steps required to permanently delete your user profile and data."},
    {"question": "How do I exit the app?", "answer": "Simple instructions on closing the application."},
    {"question": "Why did my payment not working?", "answer": "Troubleshooting steps for failed transactions."},
    {"question": "Why are the delivery fee different?", "answer": "Explanation of dynamic delivery fee calculations."},
    {"question": "Why can't I add a new payment method?", "answer": "Solutions for payment method registration issues."},
    {"question": "Why didn't I get the e-receipt after payment?", "answer": "Guidance on locating your payment receipt."},
  ];

  final List<Map<String, dynamic>> _contactOptions = const [
    {"title": "Customer Service", "icon": Icons.headset_mic_outlined, "color": AppColors.primary},
    {"title": "WhatsApp", "icon": FontAwesomeIcons.whatsapp, "color": Colors.green},
    {"title": "Website", "icon": Icons.language_outlined, "color": Colors.blueGrey},
    {"title": "Facebook", "icon": FontAwesomeIcons.facebook, "color": Colors.blue},
    {"title": "Twitter", "icon": FontAwesomeIcons.twitter, "color": Colors.lightBlue},
    {"title": "Instagram", "icon": FontAwesomeIcons.instagram, "color": Colors.pink},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // --- Search Filter Logic ---
  List<Map<String, String>> get _filteredFaqs {
    if (_searchController.text.isEmpty) {
      return _faqItems;
    }
    return _faqItems.where((item) =>
        item["question"]!.toLowerCase().contains(_searchController.text.toLowerCase())
    ).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text("Help Center"),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textFaded,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: "FAQ"),
            Tab(text: "Contact us"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFAQTab(),
          _buildContactTab(),
        ],
      ),
    );
  }

  // --- FAQ TAB ---
  Widget _buildFAQTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Chips
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _faqCategories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Chip(
                    label: Text(_faqCategories[index]),
                    backgroundColor: index == 0 ? AppColors.primary : AppColors.cardBackground,
                    labelStyle: TextStyle(
                      color: index == 0 ? AppColors.white : AppColors.textFaded,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search, color: AppColors.textFaded),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: AppColors.textFaded),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 24),

          // Collapsible FAQ List
          ..._filteredFaqs.map((faq) => _buildFaqItem(faq)).toList(),
        ],
      ),
    );
  }

  Widget _buildFaqItem(Map<String, String> faq) {
    return ExpansionTile(
      title: Text(faq["question"]!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(faq["answer"]!, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }

  // --- CONTACT US TAB ---
  Widget _buildContactTab() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: _contactOptions.map((option) => _buildContactItem(option)).toList(),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          Icon(option["icon"], color: option["color"], size: 24),
          const SizedBox(width: 16),
          Text(option["title"], style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textFaded),
        ],
      ),
    );
  }
}