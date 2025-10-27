import 'package:amar_shoday/features/theme/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import '../features/language/language_toggle_button.dart';
import '../core/constants/colors.dart';

class TopBarL2 extends StatelessWidget {
  final String location;

  const TopBarL2({Key? key, this.location = "Bosila, Dhaka"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
              Text(
                location,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const LanguageToggleButton(), // global toggle

          IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              }),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final String location;

  const TopBar({Key? key, this.location = "Bosila, Dhaka"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
              Text(
                location,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
