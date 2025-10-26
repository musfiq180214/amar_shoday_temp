import 'dart:async';
import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:amar_shoday/features/cart/presentation/floating_cart.dart';
import 'package:amar_shoday/features/landing_2/widget/landing_2_widgets.dart';
import 'package:amar_shoday/features/support/widgets/floating_support.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:amar_shoday/widgets/top_bar.dart';
// import 'package:amar_shoday/features/Cart/presentation/floating_cart.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LandingPage2 extends StatefulWidget {
  const LandingPage2({super.key});

  @override
  State<LandingPage2> createState() => _LandingPage2State();
}

class _LandingPage2State extends State<LandingPage2>
    with SingleTickerProviderStateMixin {
  int _navIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Floating cart
  Offset cartPosition = const Offset(300, 425);
  late final AnimationController _cartAnimationController;
  late Animation<Offset> _cartAnimation;

  final categories = const [
    "Groceries",
    "Meat",
    "Vegetable",
    "Dairy",
    "Cosmetics",
    "Medicine"
  ];

  final Map<String, String> categoryRoutes = const {
    "Groceries": RouteNames.groceryScreen,
    // "Meat": RouteNames.meat,
    // "Vegetable": RouteNames.vegetable,
    // "Dairy": RouteNames.dairy,
    // "Cosmetics": RouteNames.cosmetics,
    // "Medicine": RouteNames.medicine,
  };

  final recommended = const [
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
  final grocery = const [
    "Soyabin Oil",
    "Sunflower Oil",
    "Rice Bran Oil",
    "Olive Oil",
    "Mustard Oil",
    "Edible Oil",
    "Canola Oil",
    "Coconut Oil"
  ];
  final topSales = const [
    "Aarong Milk",
    "Maggie Noodles",
    "Radhuni Chilli",
    "Local Onion",
  ];

  final Map<String, String> categoryImages = const {
    "Groceries": "assets/groceries.png",
    "Meat": "assets/meat.png",
    "Vegetable": "assets/veg.png",
    "Dairy": "assets/dairy.png",
    "Cosmetics": "assets/cosmetics.png",
    "Medicine": "assets/medicine.png",
  };

  final Map<String, String> recommendedImages = const {
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

  final Map<String, String> groceryImages = const {
    "Soyabin Oil": "assets/soyabin_oil.png",
    "Sunflower Oil": "assets/sunflower_oil.png",
    "Rice Bran Oil": "assets/rice_bran_oil.png",
    "Olive Oil": "assets/olive_oil.png",
    "Mustard Oil": "assets/mustard_oil.png",
    "Edible Oil": "assets/edible_oil.png",
    "Canola Oil": "assets/canola_oil.png",
    "Coconut Oil": "assets/coconut_oil.png"
  };

  final Map<String, String> topSaleImages = const {
    "Aarong Milk": "assets/aarong_milk.png",
    "Maggie Noodles": "assets/maggie.png",
    "Radhuni Chilli": "assets/radhuni_chilli.png",
    "Local Onion": "assets/local_onion.png",
  };

  final PageController _promoController = PageController();
  final PageController _adController = PageController();
  Timer? _promoTimer;
  Timer? _adTimer;
  int _adPage = 0;

  final int _adCount = 3;

  @override
  void initState() {
    super.initState();

    _startAutoScroll(_promoController, 4, (timer) => _promoTimer = timer);
    _startAdAutoScroll();
    _adController.addListener(() {
      if (_adController.hasClients && _adController.page != null) {
        int newPage = _adController.page!.round();
        if (newPage != _adPage) setState(() => _adPage = newPage);
      }
    });

    _cartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _cartAnimationController.addListener(() {
      setState(() {
        cartPosition = _cartAnimation.value;
      });
    });
  }

  void _startAutoScroll(PageController controller, int pageCount,
      void Function(Timer) assignTimer) {
    int page = 0;
    assignTimer(Timer.periodic(const Duration(seconds: 3), (_) {
      if (controller.hasClients) {
        page++;
        if (page >= pageCount) page = 0;
        controller.animateToPage(
          page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }));
  }

  void _startAdAutoScroll() {
    _adTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_adController.hasClients) {
        _adPage++;
        if (_adPage >= _adCount) _adPage = 0;
        _adController.animateToPage(
          _adPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _promoTimer?.cancel();
    _adTimer?.cancel();
    _promoController.dispose();
    _adController.dispose();
    _cartAnimationController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  const TopBarL2(),
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(24)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${'hello'.tr()}\n${'welcome_to_amar_shoday'.tr()}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
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
          body: _buildBody(),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _navIndex,
            onTap: (index) {
              setState(() => _navIndex = index);
            },
          ),
        ),
        FloatingCart(),
        FloatingSupport(),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          _buildPromotion(),
          const SizedBox(height: 16),
          _buildCategoriesSection(),
          const SizedBox(height: 16),
          _sectionWithHorizontalItems(
            "recommended_products".tr(),
            recommended,
            itemImages: recommendedImages,
            bordered: true,
            routeName: RouteNames.reccProducts,
          ),
          _sectionWithHorizontalItems("grocery_items".tr(), grocery,
              itemImages: groceryImages,
              bordered: true,
              routeName: RouteNames.groceryScreen),
          const SizedBox(height: 12),
          _buildAds(),
          _buildSectionTitle("top_sales".tr()),
          _buildTopSales(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.indigo.shade900,
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
                  style: const TextStyle(
                    color: Colors.black, // ✅ input text color
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search_by_product_brand'.tr(),
                    hintStyle: const TextStyle(
                      color: Colors.black, // ✅ force hint text to black
                    ),
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
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String title, {
    Color textColor = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold,
    String? fontFamily,
    VoidCallback? onViewAll, // 👈 added callback
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: Text(
              "view_all".tr(),
              style: const TextStyle(
                color: Colors.black, // 👈 text color
                decoration: TextDecoration.underline, // 👈 underline enabled
                decorationColor: Colors.black, // 👈 underline color black
                fontFamily:
                    'YourFontFamily', // optional, keep your variable if needed
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotion() {
    return Stack(
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
              "promotion".tr(),
              textColor: AppColors.bgColor,
              fontSize: 20,
            ),
            SizedBox(
              height: 160,
              child: PageView(
                controller: _promoController,
                children: [
                  const Image(image: AssetImage("assets/Promotion1.png")),
                  _promoCard("GET YOUR\n GROCERIES\n DELIVERED\n IN MINUTES"),
                  _promoCard("Discount up to 50% on\n Fresh Vegetables"),
                  _promoCard("Shop Now & Get\n Free Delivery"),
                ],
              ),
            ),
          ],
        ),
      ],
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Text("view_all".tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                  ))
            ],
          ),
        ),
        _buildCategories(),
      ],
    );
  }

  Widget _buildAds() {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView(
            controller: _adController,
            children: [
              const Image(image: AssetImage("assets/super_sale.png")),
              _adBanner("Ad Banner 2"),
              _adBanner("Ad Banner 3"),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_adCount, (index) {
            bool isActive = index == _adPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 16 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTopSales() {
    return Container(
      color: AppColors.bgColor,
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: topSales.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final name = topSales[index];
          final imgPath = topSaleImages[name];
          return SizedBox(
            width: 100,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.orange.shade300,
                  child: ClipOval(
                    child: imgPath != null
                        ? Image.asset(
                            imgPath,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              name[0],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 6),
                Flexible(
                  child: Text(name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return const CategoriesWidget();
  }

  Widget _promoCard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Center(
        child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }

  Widget _adBanner(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.orange.shade300,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Center(
        child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  Widget _sectionWithHorizontalItems(
    String title,
    List items, {
    Map<String, String>? itemImages,
    bool bordered = false,
    String? routeName, // 👈 new parameter for navigation route
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          title,
          onViewAll: routeName == null
              ? null
              : () {
                  Navigator.pushNamed(context, routeName);
                },
        ),
        Container(
          color: AppColors.bgColor,
          height: 140, // increased height to accommodate bigger images
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              final imgPath = itemImages?[item];
              return Stack(children: [
                Container(
                  width: 100,
                  decoration: bordered
                      ? BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                        )
                      : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (imgPath != null)
                        Image.asset(
                          imgPath,
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        )
                      else
                        Text(item.toString().substring(0, 1),
                            style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(
                        style: const TextStyle(color: Colors.black),
                        item.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
                    child: const Icon(Icons.favorite_border,
                        color: Colors.green, size: 16),
                  ),
                ),
              ]);
            },
          ),
        ),
      ],
    );
  }
}
