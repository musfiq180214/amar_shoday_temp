import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:amar_shoday/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _currentIndex = 1; // ✅ matches the nav index for Categories

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                TopBar(),
              ],
            ),
          )),
      body: const Center(
        child: Text(
          "Categories Content Here",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() => _currentIndex = index);
            }
          },
        ),
      ),
    );
  }
}
