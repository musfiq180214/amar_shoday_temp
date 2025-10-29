// // // suggest_area_page.dart
// // import 'package:amar_shoday/core/routes/route_names.dart';
// // import 'package:flutter/material.dart';

// // class SuggestAreaPage extends StatefulWidget {
// //   const SuggestAreaPage({super.key});

// //   @override
// //   State<SuggestAreaPage> createState() => _SuggestAreaPageState();
// // }

// // class _SuggestAreaPageState extends State<SuggestAreaPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   String? name, phone, district, thana, age, occupation, email, areYou;

// //   final districts = [
// //     "Dhaka",
// //     "Chittagong",
// //     "Khulna",
// //     "Rajshahi",
// //     "Barishal",
// //     "Sylhet"
// //   ];
// //   final thanas = ["Thana 1", "Thana 2"];
// //   final ages = ["18-25", "26-35", "36-50", "50+"];
// //   final roles = ["Student", "Professional", "Other"];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: const Text("Suggest Area"),
// //         backgroundColor: Colors.white,
// //         foregroundColor: Colors.black,
// //         elevation: 0,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                   color: Colors.amber[50],
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       "Please fill the area expansion request form",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.w500,
// //                         color: Colors.black,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 20),

// //                     // Name
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Name",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                         Text(
// //                           "*",
// //                           style: TextStyle(fontSize: 15, color: Colors.red),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: TextFormField(
// //                         style: const TextStyle(color: Colors.black),
// //                         decoration: const InputDecoration(
// //                           labelText: "Enter your name",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         validator: (v) => v == null || v.trim().isEmpty
// //                             ? "Enter your name"
// //                             : null,
// //                         onSaved: (v) => name = v,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // Phone
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Phone Number",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                         Text(
// //                           "*",
// //                           style: TextStyle(fontSize: 15, color: Colors.red),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: TextFormField(
// //                         style: const TextStyle(color: Colors.black),
// //                         decoration: const InputDecoration(
// //                           labelText: "Enter Phone number",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         keyboardType: TextInputType.phone,
// //                         validator: (v) => v == null || v.trim().isEmpty
// //                             ? "Enter your phone number"
// //                             : null,
// //                         onSaved: (v) => phone = v,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // District
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Select District",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                         Text(
// //                           "*",
// //                           style: TextStyle(fontSize: 15, color: Colors.red),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: DropdownButtonFormField<String>(
// //                         style: const TextStyle(color: Colors.black),
// //                         dropdownColor: Colors.white,
// //                         decoration: const InputDecoration(
// //                           labelText: "Select District*",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         items: districts
// //                             .map((d) => DropdownMenuItem(
// //                                   value: d,
// //                                   child: Text(
// //                                     d,
// //                                     style: const TextStyle(color: Colors.black),
// //                                   ),
// //                                 ))
// //                             .toList(),
// //                         validator: (v) =>
// //                             v == null ? "Select a district" : null,
// //                         onChanged: (v) => district = v,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // Thana
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Select Thana",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                         Text(
// //                           "*",
// //                           style: TextStyle(fontSize: 15, color: Colors.red),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: DropdownButtonFormField<String>(
// //                         style: const TextStyle(color: Colors.black),
// //                         dropdownColor: Colors.white,
// //                         decoration: const InputDecoration(
// //                           labelText: "Select Thana*",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         items: thanas
// //                             .map((t) => DropdownMenuItem(
// //                                   value: t,
// //                                   child: Text(
// //                                     t,
// //                                     style: const TextStyle(color: Colors.black),
// //                                   ),
// //                                 ))
// //                             .toList(),
// //                         validator: (v) => v == null ? "Select a thana" : null,
// //                         onChanged: (v) => thana = v,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // Age
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Age",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: DropdownButtonFormField<String>(
// //                         style: const TextStyle(color: Colors.black),
// //                         dropdownColor: Colors.white,
// //                         decoration: const InputDecoration(
// //                           labelText: "Age",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         items: ages
// //                             .map((a) => DropdownMenuItem(
// //                                   value: a,
// //                                   child: Text(
// //                                     a,
// //                                     style: const TextStyle(color: Colors.black),
// //                                   ),
// //                                 ))
// //                             .toList(),
// //                         validator: (v) => v == null ? "Select age" : null,
// //                         onChanged: (v) => age = v,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // Occupation
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Occupation",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: TextFormField(
// //                         style: const TextStyle(color: Colors.black),
// //                         decoration: const InputDecoration(
// //                           labelText: "Occupation",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         validator: (v) => v == null || v.trim().isEmpty
// //                             ? "Enter your occupation"
// //                             : null,
// //                         onSaved: (v) => occupation = v,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // Email
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Email ID",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: TextFormField(
// //                         style: const TextStyle(color: Colors.black),
// //                         decoration: const InputDecoration(
// //                           labelText: "Email ID",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         keyboardType: TextInputType.emailAddress,
// //                         validator: (v) => v == null || v.trim().isEmpty
// //                             ? "Enter your email"
// //                             : null,
// //                         onSaved: (v) => email = v,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12),

// //                     // Are you a
// //                     const Row(
// //                       children: [
// //                         Text(
// //                           "Are you a",
// //                           style: TextStyle(fontSize: 15, color: Colors.black),
// //                         ),
// //                         Text(
// //                           "*",
// //                           style: TextStyle(fontSize: 15, color: Colors.red),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Container(
// //                       color: Colors.white,
// //                       child: DropdownButtonFormField<String>(
// //                         style: const TextStyle(color: Colors.black),
// //                         dropdownColor: Colors.white,
// //                         decoration: const InputDecoration(
// //                           labelText: "Are you a*",
// //                           labelStyle: TextStyle(color: Colors.black),
// //                           border: InputBorder.none,
// //                           errorStyle: TextStyle(
// //                               color: Colors.red, fontWeight: FontWeight.bold),
// //                         ),
// //                         items: roles
// //                             .map((r) => DropdownMenuItem(
// //                                   value: r,
// //                                   child: Text(
// //                                     r,
// //                                     style: const TextStyle(color: Colors.black),
// //                                   ),
// //                                 ))
// //                             .toList(),
// //                         validator: (v) => v == null ? "Select a role" : null,
// //                         onChanged: (v) => areYou = v,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               // Submit/Next Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 50,
// //                 child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.green,
// //                       foregroundColor: Colors.white,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius:
// //                             BorderRadius.circular(8), // 👈 Rounded corners
// //                       ),
// //                       padding:
// //                           const EdgeInsets.symmetric(vertical: 14), // optional
// //                     ),
// //                     onPressed: () {
// //                       if (_formKey.currentState!.validate()) {
// //                         _formKey.currentState!.save();
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(
// //                               content: Text("Welcome to Amar Shoday")),
// //                         );
// //                         Navigator.pushReplacementNamed(
// //                             context, RouteNames.login);
// //                       }
// //                     },
// //                     child: const Text(
// //                       "Next",
// //                       style:
// //                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                     )),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:amar_shoday/core/routes/route_names.dart';
// import 'package:flutter/material.dart';

// class SuggestAreaPage extends StatefulWidget {
//   const SuggestAreaPage({super.key});

//   @override
//   State<SuggestAreaPage> createState() => _SuggestAreaPageState();
// }

// class _SuggestAreaPageState extends State<SuggestAreaPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? name, phone, district, thana, age, occupation, email, areYou;

//   final districts = [
//     "Dhaka",
//     "Chittagong",
//     "Khulna",
//     "Rajshahi",
//     "Barishal",
//     "Sylhet"
//   ];
//   final thanas = ["Thana 1", "Thana 2"];
//   final ages = ["18-25", "26-35", "36-50", "50+"];
//   final roles = ["Student", "Professional", "Other"];

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.black),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5),
//         borderSide: const BorderSide(color: Colors.black54),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//       errorStyle:
//           const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Suggest Area"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.amber[50],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Please fill the area expansion request form",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Name
//                     const Row(
//                       children: [
//                         Text(
//                           "Name",
//                           style: TextStyle(fontSize: 15, color: Colors.black),
//                         ),
//                         Text(
//                           "*",
//                           style: TextStyle(fontSize: 15, color: Colors.red),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Container(
//                       color: Colors.white,
//                       child: TextFormField(
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(
//                           labelText: "Enter your name",
//                           labelStyle: TextStyle(color: Colors.black),
//                           border: InputBorder.none,
//                           errorStyle: TextStyle(
//                               color: Colors.red, fontWeight: FontWeight.bold),
//                         ),
//                         validator: (v) => v == null || v.trim().isEmpty
//                             ? "Enter your name"
//                             : null,
//                         onSaved: (v) => name = v,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // Phone
//                     const Row(
//                       children: [
//                         Text(
//                           "Phone Number",
//                           style: TextStyle(fontSize: 15, color: Colors.black),
//                         ),
//                         Text(
//                           "*",
//                           style: TextStyle(fontSize: 15, color: Colors.red),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Container(
//                       color: Colors.white,
//                       child: TextFormField(
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(
//                           labelText: "Enter Phone number",
//                           labelStyle: TextStyle(color: Colors.black),
//                           border: InputBorder.none,
//                           errorStyle: TextStyle(
//                               color: Colors.red, fontWeight: FontWeight.bold),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         validator: (v) => v == null || v.trim().isEmpty
//                             ? "Enter your phone number"
//                             : null,
//                         onSaved: (v) => phone = v,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // District Dropdown
//                     const Row(
//                       children: [
//                         Text(
//                           "Select District",
//                           style: TextStyle(fontSize: 15, color: Colors.black),
//                         ),
//                         Text(
//                           "*",
//                           style: TextStyle(fontSize: 15, color: Colors.red),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: district,
//                       style: const TextStyle(color: Colors.black),
//                       dropdownColor: Colors.white,
//                       decoration: _dropdownDecoration("Select District*"),
//                       items: districts
//                           .map((d) => DropdownMenuItem(
//                                 value: d,
//                                 child: Text(
//                                   d,
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                               ))
//                           .toList(),
//                       validator: (v) => v == null ? "Select a district" : null,
//                       onChanged: (v) => setState(() => district = v),
//                     ),
//                     const SizedBox(height: 12),

//                     // Thana Dropdown
//                     const Row(
//                       children: [
//                         Text(
//                           "Select Thana",
//                           style: TextStyle(fontSize: 15, color: Colors.black),
//                         ),
//                         Text(
//                           "*",
//                           style: TextStyle(fontSize: 15, color: Colors.red),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: thana,
//                       style: const TextStyle(color: Colors.black),
//                       dropdownColor: Colors.white,
//                       decoration: _dropdownDecoration("Select Thana*"),
//                       items: thanas
//                           .map((t) => DropdownMenuItem(
//                                 value: t,
//                                 child: Text(
//                                   t,
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                               ))
//                           .toList(),
//                       validator: (v) => v == null ? "Select a thana" : null,
//                       onChanged: (v) => setState(() => thana = v),
//                     ),
//                     const SizedBox(height: 12),

//                     // Age Dropdown
//                     const Row(
//                       children: [
//                         Text(
//                           "Age",
//                           style: TextStyle(fontSize: 15, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: age,
//                       style: const TextStyle(color: Colors.black),
//                       dropdownColor: Colors.white,
//                       decoration: _dropdownDecoration("Age"),
//                       items: ages
//                           .map((a) => DropdownMenuItem(
//                                 value: a,
//                                 child: Text(
//                                   a,
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                               ))
//                           .toList(),
//                       validator: (v) => v == null ? "Select age" : null,
//                       onChanged: (v) => setState(() => age = v),
//                     ),
//                     const SizedBox(height: 12),

//                     // Are You a Dropdown
//                     const Row(
//                       children: [
//                         Text(
//                           "Are you a",
//                           style: TextStyle(fontSize: 15, color: Colors.black),
//                         ),
//                         Text(
//                           "*",
//                           style: TextStyle(fontSize: 15, color: Colors.red),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: areYou,
//                       style: const TextStyle(color: Colors.black),
//                       dropdownColor: Colors.white,
//                       decoration: _dropdownDecoration("Are you a*"),
//                       items: roles
//                           .map((r) => DropdownMenuItem(
//                                 value: r,
//                                 child: Text(
//                                   r,
//                                   style: const TextStyle(color: Colors.black),
//                                 ),
//                               ))
//                           .toList(),
//                       validator: (v) => v == null ? "Select a role" : null,
//                       onChanged: (v) => setState(() => areYou = v),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Submit/Next Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(8), // 👈 Rounded corners
//                       ),
//                       padding:
//                           const EdgeInsets.symmetric(vertical: 14), // optional
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("Welcome to Amar Shoday")),
//                         );
//                         Navigator.pushReplacementNamed(
//                             context, RouteNames.login);
//                       }
//                     },
//                     child: const Text(
//                       "Next",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:flutter/material.dart';

class SuggestAreaPage extends StatefulWidget {
  const SuggestAreaPage({super.key});

  @override
  State<SuggestAreaPage> createState() => _SuggestAreaPageState();
}

class _SuggestAreaPageState extends State<SuggestAreaPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, phone, district, thana, age, occupation, email, areYou;

  final districts = [
    "Dhaka",
    "Chittagong",
    "Khulna",
    "Rajshahi",
    "Barishal",
    "Sylhet"
  ];
  final thanas = ["Thana 1", "Thana 2"];
  final ages = ["18-25", "26-35", "36-50", "50+"];
  final roles = ["Student", "Professional", "Other"];

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.black54),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      suffixIcon: const Icon(Icons.arrow_drop_down,
          color: Colors.black), // Dropdown icon
      errorStyle:
          const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  InputDecoration _textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      errorStyle:
          const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Suggest Area"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Please fill the area expansion request form",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name
                    const Row(
                      children: [
                        Text("Name",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        Text("*",
                            style: TextStyle(fontSize: 15, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: _textFieldDecoration("Enter your name"),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? "Enter your name"
                          : null,
                      onSaved: (v) => name = v,
                    ),
                    const SizedBox(height: 12),

                    // Phone
                    const Row(
                      children: [
                        Text("Phone Number",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        Text("*",
                            style: TextStyle(fontSize: 15, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: _textFieldDecoration("Enter Phone number"),
                      keyboardType: TextInputType.phone,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? "Enter your phone number"
                          : null,
                      onSaved: (v) => phone = v,
                    ),
                    const SizedBox(height: 12),

                    // District Dropdown
                    const Row(
                      children: [
                        Text("Select District",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        Text("*",
                            style: TextStyle(fontSize: 15, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: district,
                      decoration: _dropdownDecoration("Select District*"),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black), // Black arrow
                      items: districts
                          .map((d) => DropdownMenuItem(
                                value: d,
                                child: Text(d,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ))
                          .toList(),
                      validator: (v) => v == null ? "Select a district" : null,
                      onChanged: (v) => setState(() => district = v),
                    ),
                    const SizedBox(height: 12),

                    // Thana Dropdown
                    const Row(
                      children: [
                        Text("Select Thana",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        Text("*",
                            style: TextStyle(fontSize: 15, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: thana,
                      decoration: _dropdownDecoration("Select Thana*"),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      items: thanas
                          .map((t) => DropdownMenuItem(
                                value: t,
                                child: Text(t,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ))
                          .toList(),
                      validator: (v) => v == null ? "Select a thana" : null,
                      onChanged: (v) => setState(() => thana = v),
                    ),
                    const SizedBox(height: 12),

                    // Age Dropdown
                    const Row(
                      children: [
                        Text("Age",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: age,
                      decoration: _dropdownDecoration("Age"),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      items: ages
                          .map((a) => DropdownMenuItem(
                                value: a,
                                child: Text(a,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ))
                          .toList(),
                      validator: (v) => v == null ? "Select age" : null,
                      onChanged: (v) => setState(() => age = v),
                    ),
                    const SizedBox(height: 12),

                    // Occupation
                    const Row(
                      children: [
                        Text("Occupation",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: _textFieldDecoration("Occupation"),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? "Enter your occupation"
                          : null,
                      onSaved: (v) => occupation = v,
                    ),
                    const SizedBox(height: 12),

                    // Email
                    const Row(
                      children: [
                        Text("Email ID",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: _textFieldDecoration("Email ID"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "Enter your email";
                        }
                        // Simple email regex
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(v.trim())) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      onSaved: (v) => email = v,
                    ),

                    const SizedBox(height: 12),

                    // Are You a Dropdown
                    const Row(
                      children: [
                        Text("Are you a",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        Text("*",
                            style: TextStyle(fontSize: 15, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: areYou,
                      decoration: _dropdownDecoration("Are you a*"),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      items: roles
                          .map((r) => DropdownMenuItem(
                                value: r,
                                child: Text(r,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ))
                          .toList(),
                      validator: (v) => v == null ? "Select a role" : null,
                      onChanged: (v) => setState(() => areYou = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Submit/Next Button
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Welcome to Amar Shoday")),
                        );
                        Navigator.pushReplacementNamed(
                            context, RouteNames.login);
                      }
                    },
                    child: const Text(
                      "Next",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
