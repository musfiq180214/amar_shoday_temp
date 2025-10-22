// lib/widgets/top_bar.dart
import 'package:amar_shoday/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TopBar extends StatelessWidget {
  final String location;

  const TopBar({Key? key, this.location = "Bosila, Dhaka"}) : super(key: key);

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
    );
  }
}
