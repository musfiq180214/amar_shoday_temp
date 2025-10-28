import 'package:amar_shoday/features/category/presentation/category_screen.dart';
import 'package:amar_shoday/features/forgot_passward/create_new_pass.dart';
import 'package:amar_shoday/features/forgot_passward/forgot1.dart';
import 'package:amar_shoday/features/forgot_passward/otp_varification.dart';
import 'package:amar_shoday/features/forgot_passward/otp_varified.dart';
import 'package:amar_shoday/features/order/order_page.dart';
import 'package:amar_shoday/features/profile/presentation/profile_screen.dart';
import 'package:amar_shoday/features/sign_up/presentation/sign_up_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
import 'package:amar_shoday/features/login/presentation/login_screen.dart';
import 'package:amar_shoday/features/onboarding/presentation/splash_page.dart';
import 'package:amar_shoday/features/onboarding/presentation/language_page.dart';
import 'package:amar_shoday/features/onboarding/presentation/suggest_area_page.dart';
import 'package:amar_shoday/features/landing_2/presentation/landing_page_2.dart';
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

      case RouteNames.forgot1:
        // Placeholder for Forgot Password Screen
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.forgot1),
          builder: (_) => const Forgot1Page(),
        );

      case RouteNames.otpverification:
        // Placeholder for OTP Verification Screen
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.otpverification),
          builder: (_) => const OtpVerificationPage(),
        );

      case RouteNames.createNewPass:
        // Placeholder for Create New Password Screen
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.createNewPass),
          builder: (_) => const CreateNewPasswordPage(),
        );

      case RouteNames.otpverified:
        // Placeholder for Create New Password Screen
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.otpverified),
          builder: (_) => const OtpVerifiedPage(),
        );

      case RouteNames.signup:
        // Placeholder for Signup Screen
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteNames.signup),
            builder: (_) => const SignUpScreen());

      case RouteNames.landing2:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.landing2),
          builder: (_) => const LandingPage2(),
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

      case RouteNames.profile:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.profile),
          builder: (_) => const ProfileScreen(),
        );

      case RouteNames.order:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.order),
          builder: (_) => const OrderPage(),
        );

      case RouteNames.AllCategories:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.AllCategories),
          builder: (_) => const AllCategoriesScreen(),
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
