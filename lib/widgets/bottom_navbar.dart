import 'package:amar_shoday/core/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:amar_shoday/core/routes/route_names.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          onTap(index);

          // Centralized navigation
          switch (index) {
            case 0:
              Navigator.pushNamed(context, RouteNames.landing2);
              break;
            case 1:
              Navigator.pushNamed(context, RouteNames.AllCategories);
              break;
            case 2:
              Navigator.pushNamed(context, RouteNames.favourites);
              break;
            case 3:
              Navigator.pushNamed(context, RouteNames.more);
              break;
          }
        },
        backgroundColor: AppColors.primaryColor, // Navbar background color
        selectedItemColor: Colors.green, // Selected icon & label
        unselectedItemColor: Colors.grey, // Unselected icon & label
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home_icon.png',
              width: 24,
              height: 24,
              color: currentIndex == 0 ? Colors.green : Colors.grey,
            ),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/categories_icon.png',
              width: 24,
              height: 24,
              color: currentIndex == 1 ? Colors.green : Colors.grey,
            ),
            label: 'categories'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/Favorite.png',
              width: 24,
              height: 24,
              color: currentIndex == 2 ? Colors.green : Colors.grey,
            ),
            label: 'favourite'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/more.png',
              width: 24,
              height: 24,
              color: currentIndex == 3 ? Colors.green : Colors.grey,
            ),
            label: 'more'.tr(),
          ),
        ],
      ),
    );
  }
}
