import 'package:amar_shoday/core/api_client.dart';
import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/features/language/language_toggle_button.dart';
import 'package:amar_shoday/features/theme/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBarL2 extends ConsumerWidget {
  final String location;

  const TopBarL2({Key? key, this.location = "Bosila, Dhaka"}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🏠 Location
          Row(
            children: [
              Image.asset("assets/location_icon.png", width: 20, height: 20),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),

          // 🌐 Language toggle
          const LanguageToggleButton(),

          // 👤 Profile icon
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),

          // 🚪 Logout button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logging out...')));

              final api = ref.read(apiClientProvider);
              final result = await api.logout();

              if (result['error'] == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result['message'])),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            child: const Text('Logout'),
          ),
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
        children: [
          Image.asset("assets/location_icon.png", width: 20, height: 20),
          const SizedBox(width: 4),
          Text(
            location,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
