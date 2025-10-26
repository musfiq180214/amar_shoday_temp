import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:amar_shoday/features/home/provider/landing_2_providers.dart';
import 'package:amar_shoday/features/login/presentation/login_screen.dart';
import 'package:amar_shoday/features/onboarding/presentation/splash_page.dart';
import 'package:amar_shoday/features/onboarding/presentation/language_page.dart';
import 'package:amar_shoday/features/onboarding/presentation/suggest_area_page.dart';
import 'package:amar_shoday/features/landing/presntation/landing.dart';
import 'package:amar_shoday/features/home/presentation/landing_page_2.dart';
import 'package:amar_shoday/features/categories/presentation/category_screen.dart';
import 'package:amar_shoday/features/favourites/presentation/favourites_page.dart';
import 'package:amar_shoday/features/more/presentation/more_page.dart';
import 'package:amar_shoday/features/recommended_products/presentation/recc_product_page.dart';
import 'package:amar_shoday/features/search_results/presentation/search_results_page.dart';
import 'package:amar_shoday/features/grocery/presentation/grocery_screen.dart';
import 'package:amar_shoday/features/cart/presentation/cart_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.root:
      case RouteNames.splash:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.splash),
          builder: (_) => const SplashPage(),
        );

      case RouteNames.language:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.language),
          builder: (_) => const LanguagePage(),
        );

      case RouteNames.suggestArea:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.suggestArea),
          builder: (_) => const SuggestAreaPage(),
        );

      case RouteNames.login:
        // ✅ Use Consumer to inject ApiClient
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.login),
          builder: (context) {
            return Consumer(
              builder: (context, WidgetRef ref, _) {
                return const LoginScreen();
              },
            );
          },
        );

      case RouteNames.landing2:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.landing2),
          builder: (_) => const LandingPage2(),
        );

      case RouteNames.catogories:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.catogories),
          builder: (_) => const CategoryScreen(),
        );

      case RouteNames.favourites:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.favourites),
          builder: (_) => const FavouritesPage(),
        );

      case RouteNames.more:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.more),
          builder: (_) => const MorePage(),
        );

      case RouteNames.landing:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.landing),
          builder: (_) => const Landing(),
        );

      case RouteNames.searchResults:
        final args = settings.arguments as Map<String, dynamic>?;
        final query = args?['query'] as String? ?? '';
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.searchResults),
          builder: (_) => SearchResultsPage(searchQuery: query),
        );

      case RouteNames.reccProducts:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.reccProducts),
          builder: (_) => const ReccProductsScreen(),
        );

      case RouteNames.groceryScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.groceryScreen),
          builder: (_) => const GroceryScreen(),
        );

      case RouteNames.cart:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.cart),
          builder: (_) => CartScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: 'Unknown-${settings.name}'),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
