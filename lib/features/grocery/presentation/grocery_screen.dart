import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:amar_shoday/features/Cart/presentation/floating_cart.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  int _currentIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  final List<String> subCategories = ["Groceries", "Meat", "Vegetables"];

  final sub_categories = const [
    "Coocking Oil",
    "Rice",
    "Spices",
  ];

  final Map<String, String> sub_categoryImages = const {
    "Coocking Oil": "assets/Cooking_Oil.png",
    "Rice": "assets/rice.png",
    "Spices": "assets/radhuni_chilli.png",
  };

  Widget _buildCategories() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: sub_categories.length,
      itemBuilder: (context, index) {
        final name = sub_categories[index];
        final imgPath = sub_categoryImages[name];
        return Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.amber[700],
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
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            Text(name),
          ],
        );
      },
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("categories".tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ),
        _buildCategories(),
      ],
    );
  }

  final List<String> products = const [
    "Soyabin Oil",
    "Sunflower Oil",
    "Rice Bran Oil",
    "Olive Oil",
    "Mustard Oil",
    "Edible Oil",
    "Canola Oil",
    "Coconut Oil"
  ];

  final Map<String, String> productImages = const {
    "Soyabin Oil": "assets/soyabin_oil.png",
    "Sunflower Oil": "assets/sunflower_oil.png",
    "Rice Bran Oil": "assets/rice_bran_oil.png",
    "Olive Oil": "assets/olive_oil.png",
    "Mustard Oil": "assets/mustard_oil.png",
    "Edible Oil": "assets/edible_oil.png",
    "Canola Oil": "assets/canola_oil.png",
    "Coconut Oil": "assets/coconut_oil.png"
  };

  Widget _buildBody() {
    List<List<String>> productRows = [];
    for (var i = 0; i < products.length; i += 3) {
      productRows.add(products.sublist(
          i, i + 3 > products.length ? products.length : i + 3));
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildCategoriesSection(),
          const SizedBox(height: 16),
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade900,
            title: const Text("Grocery Items"),
            centerTitle: true,
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
        const FloatingCart(),
      ],
    );
  }
}
