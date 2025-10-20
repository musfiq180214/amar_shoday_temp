import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReccProductsScreen extends StatelessWidget {
  const ReccProductsScreen({super.key});

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
    "Aarong Ghee"
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
    "Aarong Ghee": "assets/aarong_ghee.png"
  };

  @override
  Widget build(BuildContext context) {
    List<List<String>> productRows = [];
    for (var i = 0; i < products.length; i += 3) {
      productRows.add(products.sublist(
          i, i + 3 > products.length ? products.length : i + 3));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                        Image.asset(
                          "assets/location_icon.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "Bosila, Dhaka",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
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
                          'recommended_products'.tr(),
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
                            icon: Image.asset(
                              'assets/bell_icon.png',
                              width: 30,
                              height: 30,
                            ),
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
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // 📦 Product grid
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: imgPath != null
                                                ? FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Image.asset(imgPath),
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
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(left: 0),
              child: Image.asset("assets/empty.png", width: 60, height: 60),
            ),
          ),
        ],
      ),
    );
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
