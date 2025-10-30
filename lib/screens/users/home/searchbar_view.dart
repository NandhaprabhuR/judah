import 'package:flutter/material.dart';
import 'package:judah/screens/widgets/app_theme.dart'; //

// This is Screen 33 & 34: "Search type keyword" & "Search result not found"
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  // --- STATE FOR 'NOT FOUND' ---
  bool _showNotFound = false;

  // Dummy data from the screenshot
  final List<String> recentSearches = [
    "Italian Pizza",
    "Burger King",
    "Salad",
    "Vegetarian",
    "Dessert",
    "Pancakes"
  ];
  final List<String> popularCuisines = [
    "Breakfast",
    "Snack",
    "Fast Food",
    "Beverages",
    "Chicken",
    "Noodles",
    "Rice",
    "Seafood",
    "International"
  ];
  final List<String> allCuisines = ["Bakery & Cake", "Dessert", "Pizza"];

  // Data for the filter chips in the 'Not Found' view
  final List<Map<String, dynamic>> filters = [
    {"name": "Filter", "icon": Icons.filter_list},
    {"name": "Sort", "icon": Icons.sort},
    {"name": "Promo", "icon": null},
    {"name": "Self Pick", "icon": null},
  ];

  @override
  void initState() {
    super.initState();
    // Set initial text as shown in the screenshot
    _searchController.text = "";
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // --- 2. 'NOT FOUND' LOGIC ---
  /// Simulates a search. If not found, shows the 'Not Found' screen.
  void _performSearch(String query) {
    if (query.isEmpty) {
      _resetSearch();
      return;
    }

    // Combine all dummy data for checking
    final allItems = [...recentSearches, ...popularCuisines, ...allCuisines];

    // Check if any item contains the query (case-insensitive)
    final bool isFound = allItems.any((item) => item.toLowerCase().contains(query.toLowerCase()));

    // If not found, show the 'Not Found' screen
    if (!isFound) {
      setState(() {
        _showNotFound = true;
      });
    }
    // (If found, we do nothing and just let the user see their search term)
  }

  /// Resets the view from 'Not Found' back to 'Suggestions'
  void _resetSearch() {
    if (_showNotFound) {
      setState(() {
        _showNotFound = false;
      });
    }
  }

  // --- END 'NOT FOUND' LOGIC ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // We build a custom TextField in the AppBar's title
        title: TextField(
          controller: _searchController,
          autofocus: true, // Automatically open keyboard
          decoration: InputDecoration(
            prefixIcon:
            const Icon(Icons.search, color: AppColors.primary), //
            hintText: "Search...",
            // We use the 'focusedBorder' style from the theme
            // and apply it to the enabled state as well to match the screenshot
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
              const BorderSide(color: AppColors.primary, width: 1.5), //
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
              const BorderSide(color: AppColors.primary, width: 1.5), //
            ),
            // We override the theme's gray fill to be white
            filled: true,
            fillColor: AppColors.white, //
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            suffixIcon: IconButton(
                icon: const Icon(Icons.close, color: AppColors.textFaded), //
                onPressed: () {
                  _searchController.clear();
                  _resetSearch();
                }
            ),
          ),
          // --- 2. 'NOT FOUND' LOGIC ---
          onSubmitted: _performSearch, // Triggers search on 'enter'
          onChanged: (value) => _resetSearch(), // Resets UI when user types
          // --- END 'NOT FOUND' LOGIC ---
        ),
      ),
      // --- CONDITIONAL BODY ---
      body: _showNotFound
          ? _buildNotFoundBody()
          : _buildSuggestionsBody(),
    );
  }

  /// Body for showing search suggestions
  Widget _buildSuggestionsBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection("Recent Searches", recentSearches),
          const SizedBox(height: 30),
          _buildSection("Popular Cuisines", popularCuisines),
          const SizedBox(height: 30),
          _buildSection("All Cuisines", allCuisines),
        ],
      ),
    );
  }

  /// Body for showing 'Not Found' message
  Widget _buildNotFoundBody() {
    return Column(
      children: [
        _buildFilterBar(), // The "Filter", "Sort" chips
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder for the "Not Found" image
                Icon(
                  Icons.sentiment_dissatisfied_outlined,
                  size: 150,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 30),
                Text(
                  "Not Found",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Helper to build the horizontal filter bar for the 'Not Found' screen
  Widget _buildFilterBar() {
    return SizedBox(
      height: 60, // Set a fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _buildFilterChip(filter['name'], filter['icon']),
          );
        },
      ),
    );
  }

  /// Helper to build the GREEN filter chips (Filter, Sort, etc.)
  Widget _buildFilterChip(String label, IconData? icon) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
            color: AppColors.primary, fontWeight: FontWeight.w600), //
      ),
      avatar: icon != null
          ? Icon(icon, color: AppColors.primary, size: 18)
          : null,
      backgroundColor: AppColors.primaryLight, //
      shape: const StadiumBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }


  /// Helper widget to build a section with a title and chips
  Widget _buildSection(String title, List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12.0, // Horizontal space between chips
          runSpacing: 12.0, // Vertical space between lines of chips
          children: tags.map((tag) => _buildSuggestionChip(tag)).toList(),
        ),
      ],
    );
  }

  /// Helper widget to build a single styled suggestion chip
  /// --- THIS IS UPDATED FOR STYLE AND FUNCTION ---
  Widget _buildSuggestionChip(String label) {
    return ActionChip(
      label: Text(
        label,
        style: const TextStyle(
            color: AppColors.primary, fontWeight: FontWeight.w600), //
      ),
      // --- 3. CHIP STYLING (from first image) ---
      backgroundColor: AppColors.white, //
      shape: const StadiumBorder(
        side: BorderSide(color: AppColors.primary, width: 1.5), //
      ),
      // --- END STYLING ---
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      // --- 1. TAP ON CHIP ---
      onPressed: () {
        _searchController.text = label; // Set text in search bar
        // Move cursor to the end of the text
        _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length),
        );
        _resetSearch(); // Ensure 'Not Found' is hidden
      },
      // --- END TAP LOGIC ---
    );
  }
}