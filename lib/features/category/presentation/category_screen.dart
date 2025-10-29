import 'package:amar_shoday/features/category/provider/product_provider.dart';
import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllCategoriesScreen extends ConsumerStatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  ConsumerState<AllCategoriesScreen> createState() =>
      _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends ConsumerState<AllCategoriesScreen> {
  String? selectedSlug;
  String? selectedCategoryName;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("all_categories").tr(),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: categoriesAsync.when(
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(
                child: Text(
              'No categories available',
              style: TextStyle(color: Colors.black),
            ));
          }

          // ✅ Select first category initially (only once)
          if (!_initialized && categories.isNotEmpty) {
            _initialized = true;
            selectedSlug = categories.first.slug;
            selectedCategoryName = categories.first.name;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  "all_categories".tr(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),

              // Horizontal Category List
              SizedBox(
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedSlug == category.slug;

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        if (category.slug != null &&
                            category.slug!.isNotEmpty) {
                          setState(() {
                            selectedSlug = category.slug;
                            selectedCategoryName = category.name;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('No Sub Category or Products available'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(
                                  color: Colors.indigo.shade400,
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: category.logoUrl != null
                                  ? Image.network(
                                      category.logoUrl!,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey.shade300,
                                      alignment: Alignment.center,
                                      child: Text(
                                        category.name[0],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 6),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                category.name,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      isSelected ? Colors.indigo : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Expanded body to prevent overflow
              Expanded(
                child: selectedSlug != null
                    ? Consumer(
                        builder: (context, ref, _) {
                          final productsAsync = ref.watch(
                            selectedCategoryProductsProvider(selectedSlug!),
                          );

                          return productsAsync.when(
                            data: (data) {
                              final selectedCategory =
                                  data['selected_category'];
                              final subCategories =
                                  selectedCategory['sub_categories']
                                          as List<dynamic>? ??
                                      [];

                              if (subCategories.isEmpty) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Text(
                                      'Sorry! No products found in this category',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }

                              return SingleChildScrollView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "sub_categories".tr(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ...subCategories.map((sub) {
                                      final products =
                                          sub['products'] as List<dynamic>? ??
                                              [];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sub['name'] ??
                                                'Unnamed Subcategory',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          if (products.isNotEmpty)
                                            GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 3,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8,
                                              ),
                                              itemCount: products.length,
                                              itemBuilder: (context, index) {
                                                final p = products[index];
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      p['name_en'] ??
                                                          'Unnamed Product',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          else
                                            const Text(
                                              'No products available',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          const SizedBox(height: 16),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                            loading: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            error: (err, _) => Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  'Error loading products: $err',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'Select a category to view products',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(
            'Error loading categories: $err',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
