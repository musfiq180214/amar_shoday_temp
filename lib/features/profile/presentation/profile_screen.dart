import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/features/profile/domain/user_model.dart';
import 'package:amar_shoday/features/profile/providers/profile_provider.dart';
import 'package:amar_shoday/widgets/bell_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ref.refresh(profileProvider.future),
          child: profileAsync.when(
            data: (user) => _ProfileView(user: user),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Error: ${e.toString()}")),
          ),
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
        // 🧭 Top Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const BellIconButton(),
          ],
        ),

        const SizedBox(height: 12),

        // 👤 Profile Image
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue.shade100,
            child: const Icon(
              Icons.person,
              size: 60,
              color: Colors.blueGrey,
            ),
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
              _infoRow("Name", user.name),
              const SizedBox(height: 8),
              _infoRow("Phone Number", user.phone),
              const SizedBox(height: 8),
              _infoRow("Email", user.email),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(child: _infoRow("DOB", user.dob ?? "-")),
                  const SizedBox(width: 12),
                  Expanded(child: _infoRow("Gender", user.gender ?? "-")),
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
                    addr.details ?? "No address details provided",
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 24),

        // 👨‍👩‍👧 Recipient Section
        const Text(
          "Recipient",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (user.recipient == null || user.recipient!.name.isEmpty)
          const Text("No recipient information added.")
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
                _infoRow("Relation", user.recipient!.relation),
                const SizedBox(height: 8),
                _infoRow("Name", user.recipient!.name),
                const SizedBox(height: 8),
                _infoRow("Phone", user.recipient!.phone),
              ],
            ),
          ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
