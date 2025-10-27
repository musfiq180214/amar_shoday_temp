import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/features/profile/domain/user_model.dart';
import 'package:amar_shoday/features/profile/providers/profile_provider.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:amar_shoday/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Add your onPressed action here
            },
            icon: Image.asset(
              'assets/bell_icon.png',
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Container(
        color: Colors.yellow[100],
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => ref.refresh(profileProvider.future),
            child: profileAsync.when(
              data: (user) => _ProfileView(user: user),
              loading: () =>
                  const Center(child: Text("No profile data found.")),
              error: (e, _) => Center(child: Text("Error: ${e.toString()}")),
            ),
          ),
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

class _ProfileView extends StatelessWidget {
  final UserModel user;
  const _ProfileView({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        SizedBox(height: 8),
        // 🧭 Top Bar
        // Container(
        //   color: Colors.white,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       IconButton(
        //         onPressed: () => Navigator.pop(context),
        //         icon: const Icon(Icons.arrow_back_ios_new_rounded),
        //       ),
        //       Text(
        //         "Profile",
        //         style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //           color: AppColors.primaryColor,
        //         ),
        //       ),
        //       const BellIconButton(),
        //     ],
        //   ),
        // ),

        const SizedBox(height: 12),

        // 👤 Profile Image
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // --- Main square profile image ---
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blueGrey,
                ),
              ),

              // --- Asset icon at bottom-left corner ---
              Positioned(
                bottom: -5,
                left: 40,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Image.asset(
                    'assets/camera.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),
        Center(
          child: Text(
            "Joined 01 Feb 2025",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // 🧾 Personal Info Header
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Personal Info",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.edit, color: Colors.blue),
          ],
        ),

        const SizedBox(height: 12),

        // 🧍 Personal Info Block
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRowP("Name", user.name),
              const SizedBox(height: 8),
              const Divider(thickness: 1, color: Colors.grey),
              _infoRowP("Phone Number", user.phone),
              const SizedBox(height: 8),
              const Divider(thickness: 1, color: Colors.grey),
              _infoRowP("Email", user.email),
              const Divider(thickness: 1, color: Colors.grey),
              Row(
                children: [
                  Expanded(
                      child: _infoRowP("DOB", user.dob ?? "19 March 2000")),
                  const SizedBox(width: 12),
                  Expanded(child: _infoRowP("Gender", user.gender ?? "Male")),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 🏠 Address Section
        const Text(
          "Addresses",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        if (user.addresses.isEmpty)
          const Text("No saved addresses found.")
        else
          ...user.addresses.map(
            (addr) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addr.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.edit, color: Colors.blue, size: 20),
                          SizedBox(width: 8),
                          Icon(Icons.delete_outline,
                              color: Colors.red, size: 20),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    addr.details ??
                        "H-02, R-10, Bosila Garden City, Bosila, Mohammadpur, Dhaka.",
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 24),

        // 👨‍👩‍👧 Recipient Section
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recipient",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.edit, color: Colors.blue, size: 20),
          ],
        ),
        const SizedBox(height: 12),
        if (user.recipient == null || user.recipient!.name.isEmpty)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRowR("Relation", "Wife"),
                const SizedBox(height: 8),
                _infoRowR("Name", "Nusrat Fariya"),
                const SizedBox(height: 8),
                _infoRowR("Phone", "01755479660"),
              ],
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRowP("Relation", user.recipient!.relation),
                const SizedBox(height: 8),
                _infoRowP("Name", user.recipient!.name),
                const SizedBox(height: 8),
                _infoRowP("Phone", user.recipient!.phone),
              ],
            ),
          ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _infoRowP(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: label == "Relation" ? Colors.grey : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _infoRowR(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: label == "Relation" ? Colors.grey : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
