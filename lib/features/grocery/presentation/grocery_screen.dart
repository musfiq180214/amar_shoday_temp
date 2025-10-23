import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:amar_shoday/widgets/top_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:amar_shoday/features/cart/presentation/floating_cart.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  int _currentIndex = 0;
  int _selectedSubCategoryIndex = 0; // ✅ track selected subcategory
  final TextEditingController _searchController = TextEditingController();

  final sub_categories = const [
    "Cooking Oil",
    "Rice",
    "Spices",
  ];

  final Map<String, String> sub_categoryImages = const {
    "Cooking Oil": "assets/Cooking_Oil.png",
    "Rice": "assets/rice.png",
    "Spices": "assets/radhuni_chilli.png",
  };

  // ✅ Products mapped to each subcategory
  final Map<String, List<String>> categoryProducts = const {
    "Cooking Oil": [
      "Soyabin Oil",
      "Sunflower Oil",
      "Rice Bran Oil",
      "Olive Oil",
      "Mustard Oil",
      "Edible Oil",
      "Canola Oil",
      "Coconut Oil"
    ],
    "Rice": [
      "Bashmoti Rice",
      "Miniket Rice",
      "Najirshail Rice",
      "Brown Rice",
      "Chinigura Rice",
      "Atop Rice",
      "Kalijira Rice",
      "Parboiled Rice"
    ],
    "Spices": [
      "Turmeric Powder",
      "Chilli Powder",
      "Cumin Powder",
      "Coriander Powder",
      "Garam Masala",
      "Cinnamon",
      "Black Pepper",
      "Cardamom"
    ],
  };

  final Map<String, String> productImages = const {
    // Cooking Oil
    "Soyabin Oil": "assets/soyabin_oil.png",
    "Sunflower Oil": "assets/sunflower_oil.png",
    "Rice Bran Oil": "assets/rice_bran_oil.png",
    "Olive Oil": "assets/olive_oil.png",
    "Mustard Oil": "assets/mustard_oil.png",
    "Edible Oil": "assets/edible_oil.png",
    "Canola Oil": "assets/canola_oil.png",
    "Coconut Oil": "assets/coconut_oil.png",

    // Rice
    "Bashmoti Rice": "assets/rice.png",
    "Miniket Rice": "assets/rice.png",
    "Najirshail Rice": "assets/rice.png",
    "Brown Rice": "assets/rice.png",
    "Chinigura Rice": "assets/rice.png",
    "Atop Rice": "assets/rice.png",
    "Kalijira Rice": "assets/rice.png",
    "Parboiled Rice": "assets/rice.png",

    // Spices
    "Turmeric Powder": "assets/radhuni_chilli.png",
    "Chilli Powder": "assets/radhuni_chilli.png",
    "Cumin Powder": "assets/radhuni_chilli.png",
    "Coriander Powder": "assets/radhuni_chilli.png",
    "Garam Masala": "assets/radhuni_chilli.png",
    "Cinnamon": "assets/radhuni_chilli.png",
    "Black Pepper": "assets/radhuni_chilli.png",
    "Cardamom": "assets/radhuni_chilli.png",
  };

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8), // small breathing space
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9, // ✅ keeps consistent size, prevents overflow
        ),
        itemCount: sub_categories.length,
        itemBuilder: (context, index) {
          final name = sub_categories[index];
          final imgPath = sub_categoryImages[name];
          final isSelected = index == _selectedSubCategoryIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedSubCategoryIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: isSelected ? Colors.brown.shade50 : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.brown.shade100,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              margin: const EdgeInsets.symmetric(
                  vertical: 4), // ✅ prevents overflow
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.brown.shade200,
                    child: ClipOval(
                      child: imgPath != null
                          ? Image.asset(
                              imgPath,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                                name[0],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    name,
                    style: TextStyle(
                      color:
                          isSelected ? Colors.brown.shade700 : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubCategoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              const SizedBox(width: 1),
              Text("sub_categories".tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 22)),
            ],
          ),
        ),
        const SizedBox(height: 5),
        _buildCategories(),
      ],
    );
  }

  void _navigateToSearchResults() {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Navigator.pushNamed(
        context,
        RouteNames.searchResults,
        arguments: {'query': query},
      );
    }
  }

  Widget _buildSearchBar() {
    return Container(
      // color: Colors.indigo.shade900,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search_by_product_brand'.tr(),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _navigateToSearchResults(),
                  ),
                ),
                GestureDetector(
                  onTap: _navigateToSearchResults,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        Text(
                          'search'.tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildBody() {
    final selectedCategory = sub_categories[_selectedSubCategoryIndex];
    final products = categoryProducts[selectedCategory] ?? [];

    List<List<String>> productRows = [];
    for (var i = 0; i < products.length; i += 3) {
      productRows.add(products.sublist(
          i, i + 3 > products.length ? products.length : i + 3));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildSubCategoriesSection(),
          const SizedBox(height: 16),
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Text("items".tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 22)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: productRows.map((row) {
                          return Row(
                            children: List.generate(3, (index) {
                              final product =
                                  index < row.length ? row[index] : null;
                              if (product == null) {
                                return const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: SizedBox(
                                      height: 140,
                                      width: double.infinity,
                                    ),
                                  ),
                                );
                              }
                              final imgPath = productImages[product];
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 140,
                                        width: double.infinity,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 20),
                                              SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: imgPath != null
                                                    ? FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Image.asset(
                                                            imgPath),
                                                      )
                                                    : FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          product[0],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                              ),
                                              const SizedBox(height: 6),
                                              SizedBox(
                                                height: 20,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    product,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                              size: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey.shade100,
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
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.grey),
                                onPressed: () => Navigator.pop(context),
                                splashRadius: 24,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'grocery_items'.tr(),
                                    style: TextStyle(
                                      color: Colors.indigo.shade900,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const BellIconButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: _buildBody(),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index != _currentIndex) {
                setState(() => _currentIndex = index);
              }
            },
          ),
        ),
        FloatingCart(),
      ],
    );
  }
}
