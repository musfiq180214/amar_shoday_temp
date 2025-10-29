import 'package:amar_shoday/core/constants/colors.dart';
import 'package:amar_shoday/features/profile/domain/profile_usecase.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
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
              loading: () => const Center(child: CircularProgressIndicator()),
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

class _ProfileView extends ConsumerStatefulWidget {
  final UserModel user;
  const _ProfileView({required this.user});

  @override
  ConsumerState<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<_ProfileView> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _dobController = TextEditingController(text: widget.user.dob ?? '');
    _genderController =
        TextEditingController(text: _capitalizeGender(widget.user.gender));
  }

  String _capitalizeGender(String? g) {
    if (g == null) return '';
    if (g.toLowerCase() == 'male') return 'Male';
    if (g.toLowerCase() == 'female') return 'Female';
    return g;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SizedBox(height: 20),
          // 👤 Profile Image
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person,
                      size: 40, color: Colors.blueGrey),
                ),
                Positioned(
                  bottom: -5,
                  left: 40,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child:
                        Image.asset('assets/camera.png', fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Center(
            child: Text(
              "Joined 01 Feb 2025",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),

          // 🧾 Personal Info Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Personal Info",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              IconButton(
                icon: Icon(_isEditing ? Icons.save : Icons.edit,
                    color: Colors.blue),
                onPressed: () async {
                  if (_isEditing) {
                    if (_formKey.currentState!.validate()) {
                      final updateUseCase =
                          ref.read(updateProfileUseCaseProvider);
                      await updateUseCase(
                        name: _nameController.text,
                        email: _emailController.text,
                        dob: _dobController.text,
                        gender: _genderController.text.toLowerCase(),
                      );
                      ref.invalidate(profileProvider);
                      setState(() => _isEditing = false);
                    }
                  } else {
                    setState(() => _isEditing = true);
                  }
                },
              ),
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
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRowEditable("Name", _nameController),
                const SizedBox(height: 8),
                const Divider(),
                _infoRowP("Phone Number", widget.user.phone),
                const SizedBox(height: 8),
                const Divider(),
                _infoRowEditable("Email", _emailController),
                const Divider(),
                Row(
                  children: [
                    Expanded(child: _infoRowEditable("DOB", _dobController)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _infoRowEditable("Gender", _genderController)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 🏠 Address Section
          const Text("Addresses",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 12),
          if (widget.user.addresses.isEmpty)
            const Text("No saved addresses found.")
          else
            ...widget.user.addresses.map(
              (addr) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(addr.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black)),
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
                          "H-02, R-10, Bosila Garden City, Mohammadpur, Dhaka.",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _infoRowEditable(String label, TextEditingController controller) {
    if (!_isEditing) return _infoRowP(label, controller.text);

    if (label == "DOB") {
      return InkWell(
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            controller.text =
                "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
            setState(() {});
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade400, width: 1))),
          child: Text(
            controller.text.isEmpty ? "Select DOB" : controller.text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (label == "Gender") {
      return DropdownButtonFormField<String>(
        value: controller.text.isEmpty ? 'Male' : controller.text,
        items: const [
          DropdownMenuItem(value: 'Male', child: Text('Male')),
          DropdownMenuItem(value: 'Female', child: Text('Female')),
        ],
        onChanged: (value) {
          if (value != null) controller.text = value;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        ),
      );
    } else {
      return TextFormField(
        controller: controller,
        validator: (v) {
          if (label == "Email" && (v == null || !v.contains('@'))) {
            return "Enter valid email";
          }
          return null;
        },
        style: const TextStyle(fontSize: 14),
      );
    }
  }

  Widget _infoRowP(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12)),
        Text(value,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14)),
      ],
    );
  }
}
