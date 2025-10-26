// import 'package:amar_shoday/features/language/language_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:amar_shoday/core/routes/route_names.dart';

// class LanguagePage extends ConsumerStatefulWidget {
//   const LanguagePage({super.key});

//   @override
//   ConsumerState<LanguagePage> createState() => _LanguagePageState();
// }

// class _LanguagePageState extends ConsumerState<LanguagePage> {
//   String? district;
//   String? thana;
//   String? area;

//   final districts = [
//     "Dhaka",
//     "Chittagong",
//     "Khulna",
//     "Rajshahi",
//     "Barishal",
//     "Sylhet"
//   ];
//   final thanas = ["Thana 1", "Thana 2"];
//   final areas = ["Bosila city housing", "Area 2"];

//   String? errorMessage;

//   @override
//   Widget build(BuildContext context) {
//     final currentLocale = context.locale;

//     return Scaffold(
//       body: ListView(
//         children: [
//           const SizedBox(height: 40),

//           // ✅ Top Centered Title
//           Center(
//             child: Text(
//               "Selected Language",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue[700],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // ✅ Language Toggle Chips at Center
//           Center(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ChoiceChip(
//                   label: const Text(
//                     "Eng",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   selected: currentLocale == const Locale('en', 'US'),
//                   selectedColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: currentLocale == const Locale('en', 'US')
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                   onSelected: (_) {
//                     const newLocale = Locale('en', 'US');
//                     context.setLocale(newLocale);
//                     ref
//                         .read(languageNotifierProvider.notifier)
//                         .setLocale(newLocale);
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 ChoiceChip(
//                   label: const Text(
//                     "বাংলা",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   selected: currentLocale == const Locale('bn', 'BD'),
//                   selectedColor: Colors.blue,
//                   labelStyle: TextStyle(
//                     color: currentLocale == const Locale('bn', 'BD')
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                   onSelected: (_) {
//                     const newLocale = Locale('bn', 'BD');
//                     context.setLocale(newLocale);
//                     ref
//                         .read(languageNotifierProvider.notifier)
//                         .setLocale(newLocale);
//                   },
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 30),

//           // ✅ Bottom Section with Background
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.amber[50],
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Notice Text
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.amber[50],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "We are currently operating in selected areas only. Please let us know your area if it is not already in the list",
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   const Text("Select District"),

//                   const SizedBox(height: 8),

//                   Container(
//                     color: Colors.white,
//                     child: DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: "Select District",
//                         border: OutlineInputBorder(),
//                       ),
//                       initialValue: district,
//                       onChanged: (v) => setState(() => district = v),
//                       items: districts
//                           .map(
//                               (d) => DropdownMenuItem(value: d, child: Text(d)))
//                           .toList(),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   const Text("Select Thana"),

//                   const SizedBox(height: 8),

//                   // Thana Dropdown
//                   Container(
//                     color: Colors.white,
//                     child: DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: "Select Thana",
//                         border: OutlineInputBorder(),
//                       ),
//                       initialValue: thana,
//                       onChanged: (v) => setState(() => thana = v),
//                       items: thanas
//                           .map(
//                               (t) => DropdownMenuItem(value: t, child: Text(t)))
//                           .toList(),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   const Text("Select Area"),

//                   const SizedBox(height: 8),

//                   // Area Dropdown
//                   Container(
//                     color: Colors.white,
//                     child: DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: "Select Area",
//                         border: OutlineInputBorder(),
//                       ),
//                       initialValue: area,
//                       onChanged: (v) => setState(() => area = v),
//                       items: areas
//                           .map(
//                               (a) => DropdownMenuItem(value: a, child: Text(a)))
//                           .toList(),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // Error message
//                   if (errorMessage != null)
//                     Text(
//                       errorMessage!,
//                       style: const TextStyle(color: Colors.red, fontSize: 13),
//                     ),

//                   const SizedBox(height: 20),

//                   // Centered "Let us know" text block
//                   const Center(
//                     child: Text(
//                       'If you are interested to have us in your',
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Center(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           "area, ",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         GestureDetector(
//                           onTap: () => () {},
//                           child: const Text(
//                             "Let us know",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               decoration: TextDecoration.underline,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   // Next Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(8), // 👈 Rounded corners
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 14), // optional
//                       ),
//                       onPressed: () {
//                         if (district == null || thana == null || area == null) {
//                           setState(() {
//                             errorMessage =
//                                 "Please select all fields before continuing.";
//                           });
//                           return;
//                         }
//                         Navigator.pushReplacementNamed(
//                             context, RouteNames.suggestArea);
//                       },
//                       child: const Text(
//                         "Next",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:amar_shoday/features/language/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:amar_shoday/core/routes/route_names.dart';

class LanguagePage extends ConsumerStatefulWidget {
  const LanguagePage({super.key});

  @override
  ConsumerState<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguagePage> {
  String? district;
  String? thana;
  String? area;

  final districts = [
    "Dhaka",
    "Chittagong",
    "Khulna",
    "Rajshahi",
    "Barishal",
    "Sylhet"
  ];
  final thanas = ["Thana 1", "Thana 2"];
  final areas = ["Bosila city housing", "Area 2"];

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 40),

          // ✅ Top Centered Title
          Center(
            child: Text(
              "Selected Language",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ✅ Language Toggle Chips at Center
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceChip(
                  label: const Text(
                    "Eng",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // forced black
                    ),
                  ),
                  selected: currentLocale == const Locale('en', 'US'),
                  selectedColor: Colors.blue,
                  onSelected: (_) {
                    const newLocale = Locale('en', 'US');
                    context.setLocale(newLocale);
                    ref
                        .read(languageNotifierProvider.notifier)
                        .setLocale(newLocale);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text(
                    "বাংলা",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // forced black
                    ),
                  ),
                  selected: currentLocale == const Locale('bn', 'BD'),
                  selectedColor: Colors.blue,
                  onSelected: (_) {
                    const newLocale = Locale('bn', 'BD');
                    context.setLocale(newLocale);
                    ref
                        .read(languageNotifierProvider.notifier)
                        .setLocale(newLocale);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ✅ Bottom Section with Background
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.amber[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notice Text
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "We are currently operating in selected areas only. Please let us know your area if it is not already in the list",
                      style: TextStyle(color: Colors.black), // forced black
                    ),
                  ),

                  const SizedBox(height: 20),

// District Dropdown
                  const Text(
                    "Select District",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: district,
                    decoration: const InputDecoration(
                      labelText: "Select District",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      suffixIcon:
                          Icon(Icons.arrow_drop_down, color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    items: districts
                        .map((d) => DropdownMenuItem(
                              value: d,
                              child: Text(
                                d,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => district = v),
                  ),

                  const SizedBox(height: 12),

// Thana Dropdown
                  const Text(
                    "Select Thana",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: thana,
                    decoration: const InputDecoration(
                      labelText: "Select Thana",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      suffixIcon:
                          Icon(Icons.arrow_drop_down, color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    items: thanas
                        .map((t) => DropdownMenuItem(
                              value: t,
                              child: Text(
                                t,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => thana = v),
                  ),

                  const SizedBox(height: 12),

// Area Dropdown
                  const Text(
                    "Select Area",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: area,
                    decoration: const InputDecoration(
                      labelText: "Select Area",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      suffixIcon:
                          Icon(Icons.arrow_drop_down, color: Colors.black),
                    ),
                    dropdownColor: Colors.white,
                    items: areas
                        .map((a) => DropdownMenuItem(
                              value: a,
                              child: Text(
                                a,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => area = v),
                  ),

                  const SizedBox(height: 16),

                  // Error message
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),

                  const SizedBox(height: 20),

                  // Centered "Let us know" text block
                  const Center(
                    child: Text(
                      'If you are interested to have us in your',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "area, ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () => () {},
                          child: const Text(
                            "Let us know",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        if (district == null || thana == null || area == null) {
                          setState(() {
                            errorMessage =
                                "Please select all fields before continuing.";
                          });
                          return;
                        }
                        Navigator.pushReplacementNamed(
                            context, RouteNames.suggestArea);
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
