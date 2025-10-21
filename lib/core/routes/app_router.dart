import 'package:amar_shoday/features/categories/presentation/categories_page.dart';
import 'package:amar_shoday/features/favourites/presentation/favourites_page.dart';
import 'package:amar_shoday/features/grocery/presentation/grocery_screen.dart';
import 'package:amar_shoday/features/home/presentation/landing_page_2.dart';
import 'package:amar_shoday/features/more/presentation/more_page.dart';
import 'package:amar_shoday/features/onboarding/presentation/language_page.dart';
import 'package:amar_shoday/features/onboarding/presentation/splash_page.dart';
import 'package:amar_shoday/features/onboarding/presentation/suggest_area_page.dart';
import 'package:amar_shoday/features/recommended_products/presentation/recc_product_page.dart';
import 'package:amar_shoday/features/search_results/presentation/search_results_page.dart';
import 'package:flutter/material.dart';
import 'package:amar_shoday/core/routes/route_names.dart';

import 'package:amar_shoday/features/landing/presntation/landing.dart';
// import 'package:amar_shoday/features/no_internet/presentation/no_internet.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteNames.language:
        return MaterialPageRoute(builder: (_) => const LanguagePage());
      case RouteNames.suggestArea:
        return MaterialPageRoute(builder: (_) => const SuggestAreaPage());
      case RouteNames.landing2:
        return MaterialPageRoute(builder: (_) => const LandingPage2());
      case RouteNames.catogories:
        return MaterialPageRoute(builder: (_) => const CategoriesPage());
      case RouteNames.favourites:
        return MaterialPageRoute(builder: (_) => const FavouritesPage());
      case RouteNames.more:
        return MaterialPageRoute(builder: (_) => const MorePage());

      case RouteNames.landing:
        return MaterialPageRoute(
            builder: (_) => const Landing()); // your original Landing
      case RouteNames.searchResults:
        final args = settings.arguments as Map<String, dynamic>?;
        final query = args?['query'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => SearchResultsPage(searchQuery: query),
        );
      case RouteNames.reccProducts:
        return MaterialPageRoute(builder: (_) => const ReccProductsScreen());
      case RouteNames.GroceryScreen:
        return MaterialPageRoute(builder: (_) => const GroceryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
