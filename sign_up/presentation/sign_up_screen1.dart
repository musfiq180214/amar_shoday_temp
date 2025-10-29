// import 'package:flutter/material.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   bool _passwordVisible = false;
//   bool _confirmPasswordVisible = false;
//   bool _agreeTerms = false;
//   bool _loading = false;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _verify() {
//     if (_formKey.currentState!.validate() && _agreeTerms) {
//       setState(() => _loading = true);
//       // Implement your sign-up logic here
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() => _loading = false);
//       });
//     } else if (!_agreeTerms) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please agree to Terms & Conditions')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Center(
//                 child: Text(
//                   "Sign Up",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Center(
//                 child: Text(
//                   "Create Your Account",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Name Field
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       Text(
//                         "Name",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                       Text(
//                         " *",
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.normal,
//                             color: Colors.red),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       hintText: "Onasis Ador", // Placeholder inside the field
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter your name";
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // Phone Number Field
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(
//                   labelText: "Phone Number *",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your phone number";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Email Field
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: "Email ID",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     final emailRegex =
//                         RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
//                     if (!emailRegex.hasMatch(value)) {
//                       return "Enter a valid email";
//                     }
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Password Field
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: !_passwordVisible,
//                 decoration: InputDecoration(
//                   labelText: "Password *",
//                   border: const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _passwordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() => _passwordVisible = !_passwordVisible);
//                     },
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter password";
//                   }
//                   if (value.length < 8) {
//                     return "Password must be at least 8 characters";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 "Password should have at least 8 Characters, one number, one uppercase letter, one symbol",
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               const SizedBox(height: 16),

//               // Confirm Password Field
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 obscureText: !_confirmPasswordVisible,
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password *",
//                   border: const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _confirmPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() =>
//                           _confirmPasswordVisible = !_confirmPasswordVisible);
//                     },
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please confirm password";
//                   }
//                   if (value != _passwordController.text) {
//                     return "Passwords do not match";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 "Password should have at least 8 Characters, one number, one uppercase letter, one symbol",
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               const SizedBox(height: 16),

//               // Terms & Conditions Checkbox
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _agreeTerms,
//                     onChanged: (value) {
//                       setState(() => _agreeTerms = value ?? false);
//                     },
//                   ),
//                   const Expanded(
//                     child: Text("Agree with Terms & Condition"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Verify Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: _loading ? null : _verify,
//                   child: _loading
//                       ? const CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : const Text(
//                           "Verify",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Login Redirect Text
//               Center(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text("Already have an account? "),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _agreeTerms = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _verify() {
    if (_formKey.currentState!.validate() && _agreeTerms) {
      setState(() => _loading = true);
      // Implement your sign-up logic here
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _loading = false);
      });
    } else if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to Terms & Conditions')),
      );
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(),
      errorStyle:
          const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // full white background
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // title remains blue
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue, // subtitle remains blue
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        " *",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: _inputDecoration("Enter your name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.black),
                decoration: _inputDecoration("Phone Number *"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.black),
                decoration: _inputDecoration("Email ID"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final emailRegex =
                        RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.black),
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: "Password *",
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() => _passwordVisible = !_passwordVisible);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 4),
              const Text(
                "Password should have at least 8 Characters, one number, one uppercase letter, one symbol",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                style: const TextStyle(color: Colors.black),
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Confirm Password *",
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  errorStyle: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() =>
                          _confirmPasswordVisible = !_confirmPasswordVisible);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm password";
                  }
                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 4),
              const Text(
                "Password should have at least 8 Characters, one number, one uppercase letter, one symbol",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 16),

              // Terms
              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (value) {
                      setState(() => _agreeTerms = value ?? false);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "Agree with Terms & Condition",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _loading ? null : _verify,
                  child: _loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Verify",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Login Redirect
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Already have an account? ",
                        style: TextStyle(color: Colors.black)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
