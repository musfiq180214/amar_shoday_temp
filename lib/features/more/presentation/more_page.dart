import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:amar_shoday/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int _currentIndex = 3; // ✅ index for More tab

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
          "More options and settings will appear here.",
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
