import 'package:amar_shoday/features/Cart/presentation/floating_cart.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:amar_shoday/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReccProductsScreen extends StatefulWidget {
  const ReccProductsScreen({super.key});

  @override
  State<ReccProductsScreen> createState() => _ReccProductsScreenState();
}

class _ReccProductsScreenState extends State<ReccProductsScreen> {
  int _currentIndex = 0;

  final List<String> products = const [
    "Marium Date",
    "Haleem Mix",
    "Golden Apple",
    "Banana (Sagor)",
    "Orange (Big)",
    "Papaya Ripe",
    "Pomagranate",
    "Water Melon",
    "Pineapple",
    "Aarong Ghee",
    "Soyabean Oil",
    "Aci Pure Chilli",
    "Dabur Honey",
    "Diploma Milk",
    "Nescafe Classic",
    "Lux Body Wash"
  ];

  final Map<String, String> productImages = const {
    "Marium Date": "assets/Marium_Date.png",
    "Haleem Mix": "assets/haleem_mix.png",
    "Golden Apple": "assets/golden_apple.png",
    "Banana (Sagor)": "assets/Banana (Sagor).png",
    "Orange (Big)": "assets/Orange (Big).png",
    "Papaya Ripe": "assets/Papaya Ripe.png",
    "Pomagranate": "assets/Pomagranate.png",
    "Water Melon": "assets/Water_Melon.png",
    "Pineapple": "assets/PineApple.png",
    "Aarong Ghee": "assets/aarong_ghee.png",
    "Soyabean Oil": "assets/soyabin_oil.png",
    "Aci Pure Chilli": "assets/aci_pure_chili.png",
    "Dabur Honey": "assets/Dubor_Honey.png",
    "Diploma Milk": "assets/Diploma_Milk.png",
    "Nescafe Classic": "assets/Nescafe_Classic.png",
    "Lifebuoy Handwash": "assets/Lifebuoy_HandWash.png",
    "Lux Body Wash": "assets/lux_body_wash.png"
  };

  @override
  Widget build(BuildContext context) {
    List<List<String>> productRows = [];
    for (var i = 0; i < products.length; i += 3) {
      productRows.add(products.sublist(
          i, i + 3 > products.length ? products.length : i + 3));
    }

    return Stack(children: [
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
                    // Background container with rounded bottom corners
                    Container(
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    // Foreground Row with back, title, and bell icon
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Back button
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.grey),
                              onPressed: () => Navigator.pop(context),
                              splashRadius: 24,
                            ),

                            // Title
                            Expanded(
                              child: Center(
                                child: Text(
                                  'recommended_products'.tr(),
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
        body: Stack(
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
                                                      child:
                                                          Image.asset(imgPath),
                                                    )
                                                  : FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        product[0],
                                                        style: const TextStyle(
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
                                    if (product == "Marium Date")
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: _buildDiscount("35% Off"),
                                      ),
                                    if (product == "Golden Apple")
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: _buildDiscount("15% Off"),
                                      ),
                                    if (product == "Aci Pure Chilli")
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: _buildDiscount("10% Off"),
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
                                        child: const Icon(Icons.favorite_border,
                                            color: Colors.green, size: 16),
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
    ]);
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
