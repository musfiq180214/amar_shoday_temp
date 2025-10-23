import 'package:amar_shoday/features/cart/presentation/floating_cart.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:amar_shoday/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/widgets/bottom_navbar.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({super.key, required this.searchQuery});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late final TextEditingController searchController;
  int _currentIndex = 0;

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

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.searchQuery);
  }

  void _performNewSearch() {
    final newQuery = searchController.text.trim();
    if (newQuery.isNotEmpty) {
      setState(() {
        searchController.text = newQuery;
      });
    }
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
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        // ------------------ AppBar ------------------
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                const TopBar(),
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
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.grey),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'search_result'.tr(),
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          BellIconButton(
                            onPressed: () {
                              // your action here
                            },
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
        // ------------------ Body ------------------
        body: Column(
          children: [
            // Search Bar
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                            color: AppColors.secondaryColor,
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

            // Search info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    '"${searchController.text}"',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(' ${products.length} products found',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 140, // square
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final imgPath = productImages[product];
                  final discount = _getDiscount(product);

                  return _ProductItem(
                    product: product,
                    imgPath: imgPath,
                    discount: discount,
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) setState(() => _currentIndex = index);
          },
        ),
      ),
      const FloatingCart(),
    ]);
  }
}

// ---------------- Product Item Widget ----------------
class _ProductItem extends StatelessWidget {
  final String product;
  final String? imgPath;
  final String? discount;

  const _ProductItem({required this.product, this.imgPath, this.discount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130, // ✅ fixed height (equal for all)
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image area (fixed)
                SizedBox(
                  height: 60,
                  width: 60,
                  child: imgPath != null
                      ? Image.asset(
                          imgPath!,
                          fit: BoxFit.contain,
                        )
                      : const Icon(Icons.image, size: 40, color: Colors.grey),
                ),

                const SizedBox(height: 6),

                // Product name (will wrap & ellipsis inside fixed space)
                SizedBox(
                  height: 32, // ✅ fixed text area
                  child: Center(
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
              top: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  discount!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

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
              child: const Icon(
                Icons.favorite_border,
                color: Colors.green,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
