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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);

        // Optional centralized navigation handling:
        switch (index) {
          case 0:
            Navigator.pushNamed(context, RouteNames.landing2);
            break;
          case 1:
            Navigator.pushNamed(context, RouteNames.catogories);
            break;
          case 2:
            Navigator.pushNamed(context, RouteNames.favourites);
            break;
          case 3:
            Navigator.pushNamed(context, RouteNames.more);
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.indigo.shade900,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'More'),
      ],
    );
  }
}
