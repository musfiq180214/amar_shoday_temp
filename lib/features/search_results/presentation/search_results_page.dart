import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({super.key, required this.searchQuery});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final List<String> products = const [
    "Marium Date",
    "Golden Apple",
    "Banana (Sagor)",
    "Orange (Big)",
    "Papaya Ripe",
    "Pomagranate",
    "Water Melon",
    "Pineapple"
  ];

  final Map<String, String> productImages = const {
    "Marium Date": "assets/Marium_Date.png",
    "Golden Apple": "assets/golden_apple.png",
    "Banana (Sagor)": "assets/Banana (Sagor).png",
    "Orange (Big)": "assets/Orange (Big).png",
    "Papaya Ripe": "assets/Papaya Ripe.png",
    "Pomagranate": "assets/Pomagranate.png",
    "Water Melon": "assets/Water_Melon.png",
    "Pineapple": "assets/PineApple.png",
  };

  late final TextEditingController searchController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.searchQuery);
  }

  void _performNewSearch() {
    final newQuery = searchController.text.trim();
    if (newQuery.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SearchResultsPage(searchQuery: newQuery),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Container(
                color: Colors.indigo.shade900,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/location_icon.png",
                            width: 20, height: 20),
                        const SizedBox(width: 4),
                        const Text("Bosila, Dhaka",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (context.locale.languageCode == 'en') {
                          context.setLocale(const Locale('bn', 'BD'));
                        } else {
                          context.setLocale(const Locale('en', 'US'));
                        }
                      },
                      icon: const Icon(Icons.language, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(24)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.grey),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          'search_result'.tr(),
                          style: TextStyle(
                            color: Colors.indigo.shade900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: IconButton(
                            icon: Image.asset('assets/bell_icon.png',
                                width: 30, height: 30),
                            onPressed: () {},
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search by product, brand',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _performNewSearch(),
                      ),
                    ),
                    GestureDetector(
                      onTap: _performNewSearch,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.search, color: Colors.white),
                            const SizedBox(width: 4),
                            Text('search'.tr(),
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Search Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  '"${widget.searchQuery}"',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(' ${products.length} products found',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Total width of the GridView
                double totalWidth = constraints.maxWidth;
                // Number of columns
                int crossAxisCount = 3;
                // Space between items
                double spacing = 8;
                // Calculate item width
                double itemWidth =
                    (totalWidth - (crossAxisCount - 1) * spacing) /
                        crossAxisCount;
                double itemHeight = itemWidth; // force square

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio:
                        itemWidth / itemHeight, // will be 1 (square)
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imgPath = productImages[product];
                    final discount = _getDiscount(product);

                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              // Image area (fits in square)
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: imgPath != null
                                      ? Image.asset(
                                          imgPath,
                                          fit: BoxFit.contain,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : Center(
                                          child: Text(
                                            product[0],
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                ),
                              ),
                              // Text area
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    product,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Discount badge
                        if (discount != null)
                          Positioned(
                              top: 0, left: 0, child: _buildDiscount(discount)),

                        // Favorite icon
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.favorite_border,
                                color: Colors.green, size: 16),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() => _currentIndex = index);
            }
          },
        ),
      ),
    );
  }

  String? _getDiscount(String product) {
    switch (product) {
      case "Marium Date":
        return "35% Off";
      case "Golden Apple":
        return "15% Off";
      default:
        return null;
    }
  }

  Widget _buildDiscount(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
